class Mapping < ActiveRecord::Base
  belongs_to :affiliate
  belongs_to :category

  after_save :check_categories

  def check_categories
    self.destroy if category.blank?
  end

end
