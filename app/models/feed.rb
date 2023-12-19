# frozen_string_literal: true

class Feed < ActiveRecord::Base
  validates :user_id, presence: true
  serialize :value
  has_many :entries
  belongs_to :user
  after_save :recreate_entries

  def recreate_entries
    my_entries = value.try(:entries)
    return if my_entries.blank?

    my_entries.each do |my_entry|
      entry = Entry.where(feed_id: id, entry_identifier: my_entry.entry_id).first_or_initialize
      next unless entry.published != my_entry.published

      entry.title = my_entry.title
      entry.url = my_entry.url
      entry.published = my_entry.published
      entry.author = my_entry.author
      entry.entry_identifier = my_entry.entry_id
      entry.summary = my_entry.summary
      entry.content = my_entry.content
      entry.tag_list = my_entry.categories.map(&:downcase).uniq.join(',')
      entry.scope_id = user.scope_id
      entry.user_id = user.id
      entry.save
    end
  end
end
