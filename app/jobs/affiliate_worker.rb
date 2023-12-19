# frozen_string_literal: true

class AffiliateWorker < ActiveJob::Base
  def perform(*_args)
    # ZalandoPremium.run
    # ZalandoSchuhe.run
    # ZalandoMode.run
    # Stylebop.run
    # Jades.run
    Aboutyou.run
    # Topshop.run
    # Fashionette.run
    # Tibi.run
    # Billabong.run
    # Zappos.run
    # Romwe.run
    # Jimmy.run
    # Mytheresa.run
    # Breuninger.run
    # AsosDE.run
  end

  def self.run
    perform_later
  end
end
