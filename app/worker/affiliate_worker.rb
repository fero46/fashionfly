class AffiliateWorker
  include Sidekiq::Worker

  def perform
    ZalandoPremium.run
    ZalandoSchuhe.run
    ZalandoMode.run
    Stylebop.run
    Jades.run
  end

  def self.run
    perform_async()
  end

end
