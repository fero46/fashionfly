class TheHutImporter < AffiliateWindowImporter
  def product_remote_image values
    values[IMAGES].gsub('130/130', '600/600')
  end
end