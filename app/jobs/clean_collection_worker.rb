# frozen_string_literal: true

class CleanCollectionWorker < ActiveJob::Base
  def perform(*_args)
    date = Date.today - 7.days
    collection_to_destroy = FashionFlyEditor::Collection.where(published: false).where('created_at < ?', date)
    collection_to_destroy.destroy_all
  end

  def self.run
    perform_later
  end
end
