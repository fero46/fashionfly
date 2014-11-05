class Category < ActiveRecord::Base

    has_many :categorizations
    has_many :products, :through => :categorizations
    has_many :categories,  :dependent => :destroy
    belongs_to :category
    belongs_to :scope
    has_and_belongs_to_many :icons

    validates :name, presence: true
    validates :scope_id, presence: true

    before_save :update_slug
    before_save :update_position
    after_save :update_leaf

    def update_slug
      self.slug = create_slug(self)
    end

    def create_slug cati
      return "" if cati.blank?
      parent = Category.where(id: cati.category_id).first
      parent_slug = ""
      parent_slug = create_slug(parent) + "-" if parent.present?
      return parent_slug + clean_name(cati.name).try(:downcase)
    end

    def update_position
      return if self.position.present?
      self.position = Category.count + 1
    end


    def update_leaf
      category.update_leaf if category.present? && category.leaf
      return if self.leaf && self.categories.count == 0 || (self.leaf.blank? || !self.leaf) && self.categories.count > 0
      self.leaf = self.categories.count == 0
      save
    end

    def name_with_parent
      slug.gsub('_', ' ')
    end

    def brands
      products.joins(:brand).group(:name)
    end


private
    def clean_name name
      return "" if name.blank?
      name.gsub('ö', 'oe').gsub('ü', 'ue').gsub('ä', 'ae').gsub('ß','ss').gsub('%', '').gsub(' ','_').gsub('&','und')
    end
end
