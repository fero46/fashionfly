class Scope < ActiveRecord::Base
  
  has_many :categories
  has_many :mappings
  has_many :products
  
  validates :country_code, presence: true, uniqueness: true
  validates :locale, presence: true


end
