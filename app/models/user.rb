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

  def email_has_to_be_validated
    errors.add(:email_confirmation, I18n.t("user.identical")) unless email_confirmation == email
  end

  def self.create_from_omniauth(params)
    pass = Devise.friendly_token
    image  = params['info']['image']
    if params['provider'] == 'facebook'
      image.gsub!('https', 'http')
      image.gsub!("http","https")
    end
    attributes = {
      email: params['info']['email'],
      email_confirmation: params['info']['email'],
      password: pass,
      password_confirmation: pass,
      name: params['info']['name'],
      remote_avatar_url: image
    }
    user = User.new(attributes)
    user.skip_confirmation!
    user.save
    user
  end


end
