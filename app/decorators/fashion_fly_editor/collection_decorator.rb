FashionFlyEditor::Collection.class_eval do
  has_many :favorites, as: :markable, dependent: :destroy

  def self.trends
    where(published: true).order('actual_trend DESC')
  end
end