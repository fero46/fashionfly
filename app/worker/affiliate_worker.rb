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
    Zappos.run
    Romwe.run
    Jimmy.run
    Mytheresa.run
    Breuninger.run
  end

  def self.run
    perform_async()
  end

end
