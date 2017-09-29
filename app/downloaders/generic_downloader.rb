class GenericDownloader
  def start_importer
    @affiliate = Affiliate.where(name: name).first
    if @affiliate.present?
      unless ended?
        download_file
        @affiliate.ready = true
        @affiliate.save
      else
        begin
          @affiliate.products.destroy_all          
        rescue
        end
      end
    end
  end

  def self.run
    new.start_importer
  end

  def ended?
    false
  end
end
