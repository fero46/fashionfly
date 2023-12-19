# frozen_string_literal: true

class Brand < ActiveRecord::Base
  has_many :products
  has_and_belongs_to_many :categories, uniq: true

  before_save :make_slug

  def make_slug
    self.slug = url_safe
  end

  def create_slug
    self.slug = url_safe
    save!
  end

  def url_safe
    return '' if name.blank?

    name.downcase.gsub(/[^a-zA-Z0-9]+/, '-').gsub(/-{2,}/, '-').gsub(/^-|-$/, '')
  end
end
