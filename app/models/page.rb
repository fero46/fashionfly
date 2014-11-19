class Page < ActiveRecord::Base
  belongs_to :scope

  validates :name, presence: true, uniqueness: {scope: :scope_id} 
  validates :scope_id, presence: true
  validates :title, presence: true
end
