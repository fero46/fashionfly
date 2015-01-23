class ImageCropService

  def initialize(product, remote_image_path)
    @product = product
    @remote_image_path = remote_image_path
  end

  def remote_image_path
    @remote_image_path
  end

  def product
    @product
  end

  def image_cut_out(save_original = true)
    cut_out_without_mask(save_original)
  end

  def cut_out_without_mask(save_original=true)
    full_path_to_tmp = Rails.root.to_s + "/tmp/"
    image_path = full_path_to_tmp+"#{product.id}_image.png"
    output_path = full_path_to_tmp+"#{product.id}_out.png"

    download_image(image_path)

    if save_original
      product.original = File.open(image_path)
      product.save      
    end

    add_white_border = "convert #{image_path} -bordercolor white -border 3x3 #{image_path}"
    remove_background_cmd = "convert #{image_path} -fill none -fuzz 4% -draw 'matte 0,0 floodfill' -flop  -draw 'matte 0,0 floodfill' -flop #{output_path}"

    system add_white_border
    system remove_background_cmd
    crop_image(output_path, output_path)
    dimension(output_path)
    product.match_color(output_path)

    product.image = File.open(output_path)
    product.save

    File.delete(image_path) if File.exist?(image_path)
    File.delete(output_path) if File.exist?(output_path)

  end


  def cut_out_with_mask
    full_path_to_tmp = Rails.root.to_s + "/tmp/"   
    image_path = full_path_to_tmp+"#{product.id}_image.png"
    difference_path = full_path_to_tmp+"#{product.id}_difference.png"
    halo_mask = full_path_to_tmp + "#{product.id}_halo.png"
    output_path = full_path_to_tmp+"#{product.id}_out.png"
    with_border =  full_path_to_tmp+"#{product.id}_bordered.png"
    trimmed_out = full_path_to_tmp+"#{product.id}_trimmed.png"

    File.open(image_path, "wb") do |saved_file|
      # the following "open" is provided by open-uri
      open(remote_image_path, "rb") do |read_file|
        saved_file.write(read_file.read)
      end
    end

    product.original = File.open(image_path)
    product.save

    open(image_path, 'wb') do |dest|
      open(remote_image_path, 'rb') do |src|
        dest.write(src.read)
      end
    end

    alpha_command = "convert #{image_path} \\( +clone -fx 'p{0,0}' \\) \
          -compose Difference  -composite  \
          -modulate 100,0  -alpha off  #{difference_path}"

    halo_command = "convert #{difference_path} -bordercolor black -border 1 \
          -threshold 3%  -blur 0x1  #{halo_mask}"
    result_command = "convert #{image_path} -bordercolor white -border 1  #{halo_mask} \
                      -alpha Off -compose CopyOpacity -composite  #{output_path}"

    border_command = "convert #{output_path} -bordercolor none -border 3x3 #{with_border}"

    trim_command = "convert #{with_border} -trim +repage #{trimmed_out}"


    system alpha_command
    system halo_command
    system result_command
    system border_command
    system trim_command

    img = MiniMagick::Image.open(trimmed_out)
    
    product.width  = img['width']
    product.height = img['height']

    product.image = File.open(trimmed_out)
    product.save

    #colormatch
    product.match_color(trimmed_out)
    
    #cleanup
    File.delete(image_path) if File.exist?(image_path)
    File.delete(difference_path) if File.exist?(difference_path)
    File.delete(halo_mask) if File.exist?(halo_mask)
    File.delete(output_path) if File.exist?(output_path)
    File.delete(with_border) if File.exist?(with_border)
    File.delete(trimmed_out) if File.exist?(trimmed_out)
  end

private 

  def download_image image_path 
    open(image_path, 'wb') do |dest|
      open(remote_image_path, 'rb') do |src|
        dest.write(src.read)
      end
    end
    rescue
      raise "UNABLE TO LOAD IMAGE #{image_path}"
  end

  def crop_image(src, output)
    full_path_to_tmp = Rails.root.to_s + "/tmp/"   
    with_border =  full_path_to_tmp+"#{product.id}_bordered.png"
    border_command = "convert #{src} -bordercolor none -border 3x3 #{with_border}"
    trim_command = "convert #{with_border} -trim +repage #{output}"
    system border_command
    system trim_command
    File.delete(with_border) if File.exist?(with_border)
  end

  def dimension(image)
    img = MiniMagick::Image.open(image)
    product.width  = img['width']
    product.height = img['height']
    product.save
  end

end