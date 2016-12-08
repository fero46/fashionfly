class AffiliateWorker
  include Sidekiq::Worker

  def perform
    ZalandoPremium.run
    ZalandoSchuhe.run
    ZalandoMode.run
    Stylebop.run
    Jades.run
    Aboutyou.run
    Topshop.run
    Fashionette.run
    Tibi.run
    Billabong.run
  end

  def self.run
    perform_async()
  end

end
