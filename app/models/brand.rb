class Brand < ActiveRecord::Base
  has_many :products
  has_and_belongs_to_many :categories, :uniq => true
end
