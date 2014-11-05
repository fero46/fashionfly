class Affiliate < ActiveRecord::Base
  belongs_to :scope
  has_many :mappings,  :dependent => :destroy

  def self.IMPORTERS
    [:GenericImporter, :AffilinetImporter]
  end

  mount_uploader :file, FileUploader


  validates :file, :presence  => true
  validates :name, :presence  => true
  validates :importer, :presence  => true
  validates :category_tag, :presence  => true
  validates :item_tag, :presence  => true

  accepts_nested_attributes_for :mappings, :allow_destroy => true, :reject_if => proc { |a| a['category_id'].blank? }


  def start_import
    importer.constantize.new(self).import
  end

  def categories
    importer.constantize.new(self).categories    
  end

end
