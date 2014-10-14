class Mapping < ActiveRecord::Base
  belongs_to :scope
  belongs_to :category
end
