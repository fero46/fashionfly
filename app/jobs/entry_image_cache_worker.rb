# frozen_string_literal: true

class EntryImageCacheWorker < ActiveJob::Base
  def perform(entry_id)
    entry = Entry.where(id: entry_id).first
    entry.cache_remote_image if entry.present?
  end

  def self.run(entry_id)
    perform_later(entry_id)
  end
end
