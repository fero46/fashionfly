class Banner < ActiveRecord::Base
  belongs_to :scope
  validates :name, presence: true
  validates :link, presence: true
  validates :banner, presence: true
  validates :preview_ids, presence: true
  validates :previews_model, presence: true
  validates :scope_id, presence: true
  mount_uploader :banner, SliderUploader
  def self.MODELS
    [:Product, :Collection]
  end
end
