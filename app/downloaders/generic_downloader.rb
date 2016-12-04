class GenericDownloader

  def start_importer
    @affiliate = Affiliate.where(name: name).first
    if @affiliate.present?
      download_file
      @affiliate.ready = true
      @affiliate.save
    end
  end

  def self.run
    new.start_importer
  end
  
end
