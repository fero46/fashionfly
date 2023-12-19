# frozen_string_literal: true

class ImportPrepareWorker < ActiveJob::Base
  def perform
    affiliates = Affiliate.where(ready: true, importing: false)
    affiliates.each do |affiliate|
      affiliate.importing = true
      affiliate.save
      ImporterWorker.run_importer(affiliate)
    end
  end

  def self.prepare
    perform_later
  end
end
