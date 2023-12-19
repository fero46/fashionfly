# frozen_string_literal: true

class Category < ActiveRecord::Base
  has_many :categorizations
  has_many :products, through: :categorizations
  has_many :categories, dependent: :destroy
  belongs_to :category
  belongs_to :scope
  has_and_belongs_to_many :icons
  has_and_belongs_to_many :brands, uniq: true

  validates :name, presence: true
  validates :scope_id, presence: true
  validates :slug, uniqueness: true

  before_save :update_slug
  before_save :update_position
  after_save :update_leaf

  def update_slug
    default = create_slug(self)
    myslug = default
    counter = 0
    other_category = Category.where(slug: myslug).first
    while other_category.present? && other_category.id != id
      counter += 1
      myslug = "#{default}_#{counter}"
      other_category = Category.where(slug: myslug).first
    end
    self.slug = myslug
  end

  def create_slug(category)
    return '' if category.blank?

    parent = category.category
    parent_slug = "#{create_slug(parent)}_"
    parent_slug + clean_name(category.name).try(:downcase)
  end

  def update_position
    return if position.present?

    self.position = Category.count + 1
  end

  def update_leaf
    category.update_leaf if category.present? && category.leaf
    return if leaf && categories.count.zero? || (leaf.blank? || !leaf) && categories.count.positive?

    self.leaf = categories.count.zero?
    save
  end

  def name_with_parent
    slug.gsub('_', ' ')
  end

  def brands
    products.joins(:brand).group(:name)
  end

  private

  def clean_name(name)
    return '' if name.blank?

    name.gsub('ö', 'oe').gsub('ü', 'ue').gsub('ä', 'ae').gsub('ß', 'ss').gsub('%', '').gsub(' ', '_').gsub('&', 'und')
  end
end
