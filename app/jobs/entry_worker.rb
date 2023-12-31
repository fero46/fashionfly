# frozen_string_literal: true

class EntryWorker < ActiveJob::Base
  def perform
    User.where(is_blogger: true).find_in_batches(batch_size: 500) do |group|
      group.each(&:update_blogging_feed)
    end
  end

  def self.run
    perform_later
  end
end
