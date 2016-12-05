class ImporterWorker
  include Sidekiq::Worker

  def perform(affiliate_id)
    affiliate = Affiliate.where(id: affiliate_id).first
    if affiliate.ready  && affiliate.importing
      affiliate.start_import
      affiliate.ready = false
      affiliate.importing = false
      affiliate.skip_items = 0
      affiliate.percent = 100
      affiliate.save
    end
  end

  def self.run_importer affiliate
    return if affiliate.blank?
    puts affiliate.ready  && affiliate.importing
    perform_async(affiliate.id)
  end

end
