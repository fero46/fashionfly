class User < ActiveRecord::Base
  TEMP_EMAIL = 'change@mymail.com'
  TEMP_EMAIL_REGEX = /change@mymail.com/

  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update
  has_many :authentications, class_name: 'UserAuthentication', dependent: :destroy
  has_many :favorites
  has_many :comments
  has_many :collections, class_name: 'FashionFlyEditor::Collection'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :database_authenticatable, :registerable,:async,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  ratyrate_rater

  mount_uploader :avatar, AvatarUploader
  mount_uploader :banner, BannerUploader

  auto_html_for :info do
    html_escape
    image
    instagram
    youtube(:width => 400, :height => 250, :autoplay => false)
    vimeo
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end

  attr_accessor :email_confirmation

  validate :email_has_to_be_validated, on: :create
  validate :email_has_to_be_validated, if: :should_confirm?
  validates :name, presence: true, uniqueness: true

  before_save  :update_slug
  before_create :make_secret

  def email_has_to_be_validated
    errors.add(:email_confirmation, I18n.t("user.identical")) if email_confirmation != email
  end

  def should_confirm?
    @confirm_email ||= false
  end

  def update_slug
    default = create_slug
    myslug = default
    counter = 0
    other_category = User.where(slug: myslug).first 
    while other_category.present? && other_category.id != self.id
      counter+=1
      myslug = "#{default}_#{counter}"
      other_category = User.where(slug: myslug).first 
    end
    self.slug=myslug
  end

  def make_secret
    self.secret = SecureRandom.hex(64)
  end

  def create_slug
    clean_name.downcase
  end

  def confirm_email
    @confirm_email = true
  end

  def email_has_to_change?
    (!email || email =~ TEMP_EMAIL_REGEX).present?
  end

  def self.create_from_omniauth(params)
    puts params.to_yaml
    pass = Devise.friendly_token
    image  = params['info']['image']
    if params['provider'] == 'facebook'
      image.gsub!('https', 'http')
      image.gsub!("http","https")
      image=image+"?type=large"
    elsif params['provider'] == 'twitter'
      image = image.sub("_normal", "")
    end
    
    t_name = params['info']['name'] || params['info']['nickname']  || auth.uid
    myname = t_name
    numb = 0
    while User.where(:name => myname).present?
      numb+=1
      myname = "#{t_name}#{count}"
    end
    t_name = myname

    mail = params['info']['email'].present? ? params['info']['email'] : TEMP_EMAIL

    if mail == TEMP_EMAIL
      numb = 1
      while User.where(email: mail).present? 
        mail = numb.to_s + TEMP_EMAIL
        numb = numb + 1
      end
    end

    attributes = {
      password: pass,
      password_confirmation: pass,
      name: t_name,
      remote_avatar_url: image
    }
    puts attributes.to_yaml
    puts mail
    user = User.new(attributes)
    user.email = mail
    user.email_confirmation =  mail
    user.skip_confirmation!
    user.confirm!
    user
  end

  def is_admin?
    self.role == "ADMIN"
  end

  def is_team?
    self.role == "TEAM" || is_admin?
  end

private

  def clean_name
    name.gsub('ö', 'oe').gsub('ü', 'ue').gsub('ä', 'ae').gsub('ß','ss').gsub('%', '').gsub(' ','_')
  end
end
