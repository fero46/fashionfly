class Category < ActiveRecord::Base

    has_many :categorizations
    has_many :products, :through => :categorizations
    has_many :categories
    belongs_to :category
    belongs_to :scope
    validates :name, presence: true
    validates :scope_id, presence: true

    before_save :update_slug

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

private
    def clean_name name
      return "" if name.blank?
      name.gsub('ö', 'oe').gsub('ü', 'ue').gsub('ä', 'ae').gsub('ß','ss').gsub('%', '').gsub(' ','_').gsub('&','und')
    end
end
