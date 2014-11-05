class Scope < ActiveRecord::Base
  
  has_many :categories
  has_many :affiliates
  has_many :products
  has_many :contests
    
  validates :country_code, presence: true, uniqueness: true
  validates :locale, presence: true



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

end
