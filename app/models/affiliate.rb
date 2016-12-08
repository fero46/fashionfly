class Affiliate < ActiveRecord::Base
  belongs_to :scope
  has_many :mappings,  :dependent => :destroy
  has_many :products,  :dependent => :destroy
  def self.IMPORTERS
    [ :GenericImporter, :AffilinetImporter, :GaleriaImporter,
      :GermanEspritImporter, :ReklamActionImporter, :MomodaImporter,:ExtendedReklamActionImporter,
      :CommissionJunctionImporter, :AffiliateWindowImporter, :WConceptImporter,
      :MyBagImporter].sort
  end

  mount_uploader :file, FileUploader
  mount_uploader :logo, ShoplogoUploader


  validates :file, :presence  => true
#  validates :logo, :presence => true
  validates :name, :presence  => true
  validates :importer, :presence  => true
  validates :category_tag, :presence  => true
  validates :item_tag, :presence  => true

  accepts_nested_attributes_for :mappings, :allow_destroy => true, :reject_if => proc { |a| a['category_id'].blank? }


  def start_import
    if self.replace_only_images
      actual_counter = 0
      total_counter = products.where(published: true).count
      self.percent = 0
      self.save
      self.start_from_id
      # Destroy all Products where image is nil
      products.where('image = ?', nil).destroy_all
      products.where('id > ?', self.start_from_id).where(published: true).order(:id).find_in_batches(batch_size: 500) do |group|
        group.each do |product|
          remote_image  = product.original.url
          if Rails.env.development? || Rails.env.test?
            remote_image = "http://localhost:3000/#{remote_image}"
          end
          ImageCropService.new(product, remote_image).image_cut_out(false)
          product.collections.each do |col|
            Rebuilder.where(collection_id: col.id).first_or_create
          end
          self.start_from_id = product.id
          actual_counter+=1
          if actual_counter % 20 == 0
            self.percent = ((actual_counter.to_f/total_counter.to_f).to_f * 100).to_i
          end
          self.save
        end
      end
      Rebuilder.find_in_batches(batch_size: 500) do |group|
        group.each {|rebuilder| rebuilder.retouch}
      end
      self.replace_only_images = false
      save
    else
      importer.constantize.new(self).import
      products.where('image = ?', nil).destroy_all
      products.where(published: false).update_all( "published = 1" )
    end
    Product.dedupe(self.id)
  end

  def categories
    importer.constantize.new(self).categories
  end

  def leaf_categories
    @leaf_categories ||= scope.categories.where(leaf: true).order(:slug)
  end

  def importer_object
    importer.constantize.new(self)
  end

end
