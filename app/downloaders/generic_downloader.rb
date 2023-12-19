# frozen_string_literal: true

class GenericDownloader
  def start_importer
    @affiliate = Affiliate.where(name: name).first
    return unless @affiliate.present?

    if ended?
      begin
        @affiliate.products.destroy_all
      rescue StandardError
      end
    else
      download_file
      @affiliate.ready = true
      @affiliate.save
    end
  end

  def self.run
    new.start_importer
  end

  def ended?
    false
  end
end
