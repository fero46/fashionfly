class User < ActiveRecord::Base
  has_many :authentications, class_name: 'UserAuthentication', dependent: :destroy
  has_many :favorites
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  ratyrate_rater

  attr_accessor :email_confirmation

  validate :email_has_to_be_validated, on: :create

  def email_has_to_be_validated
    errors.add(:email_confirmation, I18n.t("user.identical")) unless email_confirmation == email
  end

  def self.create_from_omniauth(params)
    attributes = {
      email: params['info']['email'],
      password: Devise.friendly_token
    }

    create(attributes)
  end


end
