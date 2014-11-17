class User < ActiveRecord::Base
  has_many :authentications, class_name: 'UserAuthentication', dependent: :destroy
  has_many :favorites
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  ratyrate_rater

  mount_uploader :avatar, AvatarUploader

  attr_accessor :email_confirmation

  validate :email_has_to_be_validated, on: :create

  before_save :update_slug


  def email_has_to_be_validated
    errors.add(:email_confirmation, I18n.t("user.identical")) unless email_confirmation == email
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
      email: params['info']['email'],
      email_confirmation: params['info']['email'],
      password: pass,
      password_confirmation: pass,
      name: params['info']['name'],
      remote_avatar_url: image
    }
    puts params.to_yaml
    user = User.new(attributes)
    user.skip_confirmation!
    user.save
    user
  end

private

  def clean_name
    name.gsub('ö', 'oe').gsub('ü', 'ue').gsub('ä', 'ae').gsub('ß','ss').gsub('%', '').gsub(' ','_')
  end
end
