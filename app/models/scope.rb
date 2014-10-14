class Scope < ActiveRecord::Base
  validates :country_code, presence: true, uniqueness: true
  validates :locale, presence: true
end
