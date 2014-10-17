class Word < ActiveRecord::Base
  belongs_to :scope
  has_and_belongs_to_many :words
  
  validates :scope, presence: true
  validates :value, presence: true
  validates :type, presence: true
end
