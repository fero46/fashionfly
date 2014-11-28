class User < ActiveRecord::Base
  has_many :authentications, class_name: 'UserAuthentication', dependent: :destroy
  has_many :favorites
  has_many :comments
  has_many :collections, class_name: 'FashionFlyEditor::Collection'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :database_authenticatable, :registerable,
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
  validate :name, presence: true

  before_save  :update_slug
  after_create :make_secret

  def email_has_to_be_validated
    errors.add(:email_confirmation, I18n.t("user.identical")) if email_confirmation != email
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
    self.secret = self.id.to_s+SecureRandom.hex(64)
    save
  end

  def create_slug
    clean_name.downcase
  end

  def self.create_from_omniauth(params)
    pass = Devise.friendly_token
    image  = params['info']['image']
    if params['provider'] == 'facebook'
      image.gsub!('https', 'http')
      image.gsub!("http","https")
      image=image+"?type=large"
    end
    
    attributes = {
      password: pass,
      password_confirmation: pass,
      name: params['info']['name'],
      remote_avatar_url: image
    }
    user = User.new(attributes)
    user.email = params['info']['email']
    user.email_confirmation =  params['info']['email']
    user.skip_confirmation!
    user.save
    user.confirm!
    user
  end

private

  def clean_name
    name.gsub('ö', 'oe').gsub('ü', 'ue').gsub('ä', 'ae').gsub('ß','ss').gsub('%', '').gsub(' ','_')
  end
end
