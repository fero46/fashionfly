FashionFlyEditor::Collection.class_eval do
  has_many :favorites, as: :markable, dependent: :destroy

  def self.trends
    where(published: true).order('actual_trend DESC')
  end

  def products
    Product.where('id in (?)', subscriptions.where('subscriber_type = ?', ::Product).select(:subscriber_id))
  end
end