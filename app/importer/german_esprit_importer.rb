class GermanEspritImporter < GenericImporter

protected 
  
  def product_remote_image values
    remote_image = find_my_image(values)
    if remote_image.present?
      remote_image = remote_image.gsub('PicPOV_FlatView', 'PicSPV_ZoomFlat')
    end
    return remote_image
  end

  def find_my_image(values) 
    image_tags = @affiliate.image_tag.split(',')
    for image_tag in image_tags
       result = values[image_tag.strip!] 
       return result if result.present?
    end
    nil
  end

end