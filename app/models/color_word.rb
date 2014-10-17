class ColorWord < ActiveRecord::Base
  belongs_to :scope
  belongs_to :colorization
end
