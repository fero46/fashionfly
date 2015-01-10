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

  def self.country_codes_mapped_in_region
    return @region if @region.present?
    @region = {}
    for scope in Scope.where(published: true)
      co = Country.new(scope.country_code)
      @region[co.region] = {} if @region[co.region].blank?
      @region[co.region][co.subregion] = [] if @region[co.region][co.subregion].blank?
      @region[co.region][co.subregion] << {locale: scope.locale, code: scope.country_code}
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


end
