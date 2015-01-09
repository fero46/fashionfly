require "net/http"

class GermanEspritImporter < GenericImporter

protected 
  
  def product_remote_image values
    remote_image = values['largeImage']
    if remote_image.present?
      bigger = remote_image.gsub('PicPOV_FlatView', 'PicSPV_ZoomFlat')
      url = URI.parse(bigger)
      req = Net::HTTP.new(url.host, url.port)
      res = req.request_head(url.path)
      remote_image = bigger if res.code == "200"
    end
    return remote_image
  end

end