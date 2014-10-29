class Scope < ActiveRecord::Base
  
  has_many :categories
  has_many :affiliates
  has_many :products
  has_many :contests
    
  validates :country_code, presence: true, uniqueness: true
  validates :locale, presence: true


end
