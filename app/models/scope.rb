class Scope < ActiveRecord::Base
  
  has_many :categories
  has_many :affiliates
  has_many :products
  has_many :contests
  has_many :outfit_categories, class_name: 'FashionFlyEditor::Category'
  has_many :child_outfit_categories, class_name: 'FashionFlyEditor::Category',  as: :parent, :dependent => :destroy
  has_many :subscriptions, class_name: 'FashionFlyEditor::Subscription', as: :subscriber
  has_many :collections, through: :subscriptions, class_name: 'FashionFlyEditor::Collection'
  has_many :pages
  has_many :hashtags, class_name: 'SimpleHashtag::Hashtag'
  has_many :shops
  has_many :banners
  has_many :users

  validates :country_code, presence: true, uniqueness: true
  validates :locale, presence: true

  def page name
    mypages[:name] ||= pages.where(name: name).first
  end

  def mypages
    {}
  end

  def name
    nil
  end

  def self.countries
    return @region if @region.present?
    @region = []
    for scope in Scope.where(published: true)
      @region << {locale: scope.locale, code: scope.country_code}
    end
    @region
  end

  def add_to_contest collection
    mycontest = contests.order(created_at: :desc).first
    if mycontest.present?
      mycontest.collections << collection
    end
  end

  def has_contest?
    contests.where('startdate <= ?', Date.today).where('enddate >=?', Date.today).any?
  end

  def actual_contest
    contests.where('startdate <= ?', Date.today).order(startdate: :desc).first
  end

  def property
    Property.where(scope_id: self.id).first_or_create
  end

  def favorite_shops
    shops.where(favorite: true).order(:position).limit(6)
  end


end
