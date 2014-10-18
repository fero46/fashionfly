class Affiliate < ActiveRecord::Base
  belongs_to :scope
  has_many :mappings

  def self.IMPORTERS
    [:GenericImporter]
  end

  mount_uploader :file, FileUploader


  validates :file, :presence  => true
  validates :name, :presence  => true
  validates :importer, :presence  => true
  validates :category_tag, :presence  => true
  validates :item_tag, :presence  => true

end
