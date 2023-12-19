# frozen_string_literal: true

SimpleHashtag::Hashtag.class_eval do
  belongs_to :scope
  validates_uniqueness_of :name, scope: :scope_id
end
