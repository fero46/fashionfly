# frozen_string_literal: true

class User < ActiveRecord::Base
  TEMP_EMAIL = 'change@mymail.com'
  TEMP_EMAIL_REGEX = /change@mymail.com/.freeze
  BLOG_STATUS = %w[NONE APPLIED ACCEPTED REJECTED].freeze

  validates_format_of :email, without: TEMP_EMAIL_REGEX, on: :update
  has_many :authentications, class_name: 'UserAuthentication', dependent: :destroy
  has_many :favorites
  has_many :comments
  has_many :collections, class_name: 'FashionFlyEditor::Collection'
  belongs_to :scope
  has_one :feed
  has_many :entries
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :database_authenticatable, :registerable, :async,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  ratyrate_rater

  mount_uploader :avatar, AvatarUploader
  mount_uploader :banner, BannerUploader

  auto_html_for :info do
    html_escape
    image
    instagram
    youtube(width: 400, height: 250, autoplay: false)
    vimeo
    link target: '_blank', rel: 'nofollow'
    simple_format
  end

  attr_accessor :email_confirmation, :blog_apply

  validate :email_has_to_be_validated, on: :create
  validate :email_has_to_be_validated, if: :should_confirm?
  validates :name, presence: true, uniqueness: true

  before_save :update_slug
  before_create :make_secret
  before_save :check_blog_status

  def check_blog_status
    return true if id.blank? || !valid?

    old_value = User.find(id)
    if blog_apply == '1' && old_value.blog_status == 'NONE'
      self.blog_status = 'APPLIED'
      BloggerMailer.information(id).deliver_later
      BloggerMailer.apply(id).deliver_later
    elsif old_value.blog_status == 'APPLIED'
      if blog_status == 'ACCEPTED'
        BloggerMailer.accept(id).deliver_later
        self.is_blogger = true
      end
      BloggerMailer.denied(id).deliver_later if blog_status == 'REJECTED'
    end
  end

  def blogging_feed
    return @feed if @feed.present?

    feed = Feed.where(user_id: id).first_or_initialize
    if feed.value.blank?
      urls = [blog_feed]
      feeds = Feedjira::Feed.fetch_and_parse urls
      feed.value = feeds[blog_feed]
      feed.save
    end
    @feed = feed.value
  end

  def update_blogging_feed
    urls = [blog_feed]
    feeds = Feedjira::Feed.fetch_and_parse urls
    feed.value = feeds[blog_feed]
    feed.save
    @feed = feed.value
  end

  def email_has_to_be_validated
    errors.add(:email_confirmation, I18n.t('user.identical')) if email_confirmation != email
  end

  def should_confirm?
    @confirm_email ||= false
  end

  def update_slug
    default = create_slug
    myslug = default
    counter = 0
    other_category = User.where(slug: myslug).first
    while other_category.present? && other_category.id != id
      counter += 1
      myslug = "#{default}_#{counter}"
      other_category = User.where(slug: myslug).first
    end
    self.slug = myslug
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
    case params['provider']
    when 'facebook'
      image.gsub!('https', 'http')
      image.gsub!('http', 'https')
      image += '?type=large'
    when 'twitter'
      image = image.sub('_normal', '')
    end

    t_name = params['info']['name'] || params['info']['nickname'] || auth.uid
    myname = t_name
    numb = 0
    while User.where(name: myname).present?
      numb += 1
      myname = "#{t_name}#{count}"
    end
    t_name = myname

    mail = params['info']['email'].present? ? params['info']['email'] : TEMP_EMAIL

    if mail == TEMP_EMAIL
      numb = 1
      while User.where(email: mail).present?
        mail = numb.to_s + TEMP_EMAIL
        numb += 1
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
    user.email_confirmation = mail
    user.skip_confirmation!
    user.confirm!
    user
  end

  def is_admin?
    role == 'ADMIN'
  end

  def is_team?
    role == 'TEAM' || is_admin?
  end

  private

  def clean_name
    name.gsub('ö', 'oe')
        .gsub('ü', 'ue')
        .gsub('ä', 'ae')
        .gsub('ß', 'ss')
        .gsub('%', '')
        .gsub(' ', '_')
        .gsub('.', '_')
        .gsub(',', '_')
        .gsub(';', '_')
  end
end
