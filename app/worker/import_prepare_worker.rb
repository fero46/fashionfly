class ImportPrepareWorker
  include Sidekiq::Worker

  def perform
    affiliates = Affiliate.where(ready:true, importing: false)
    for affiliate in affiliates
      affiliate.importing = true
      affiliate.save
      ImporterWorker.run_importer(affiliate)
    end
  end

  def self.prepare
    perform_async
  end
end