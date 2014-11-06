 #encoding: utf-8 
require 'xml'
require 'fileutils'
require 'open-uri'

class GenericImporter

  def initialize affiliate
    @affiliate = affiliate
    @scope = @affiliate.scope
  end

  def categories
    categories = []
    document.root.children.each do |tag|
      if tag.name == @affiliate.item_tag
        tag.children.each do |t|
          categories << t.content if t.name == @affiliate.category_tag
        end
      end
    end
    categories.uniq
  end

  def import
    total_counter = total_count
    actual_counter = 0
    document.root.children.each do |tag|
      if tag.name == @affiliate.item_tag
        actual_counter+=1
        if actual_counter % 20 == 0
          @affiliate.percent = ((actual_counter.to_f/total_counter.to_f).to_f * 100).to_i
          @affiliate.save
        end
        id = nil
        tag.attributes.each do |a|
          id = a.value if a.name == 'id' || a.name == 'zupid'
        end
        values = {}
        tag.children.each do |t|
          values[t.name] = t.content
        end

        if find_mapping(product_category(values)).present?
          next if product_remote_image(values).blank?
          product = Product.where(affiliate_id: @affiliate.id, 
                                  affi_code: id,
                                  scope_id: @scope.id).first_or_create
          product.premium = @affiliate.premium
          product.save
          Categorization.where(product_id: product.id).destroy_all
          update_product_categories(product, values)
          next if product.lastModified==product_last_modified(values)
          product = update_product_attributes product, values
          update_product_images product, values
        else
          product = Product.where(affiliate_id: @affiliate.id, 
                        affi_code: id,
                        scope_id: @scope.id).first
          product.destroy if product.present?
        end
      end
    end
    @affiliate.percent = 100
    @affiliate.save
    true
  end

  def total_count
    counter = 0
    document.root.children.each do |tag|
        counter+=1 if tag.name == @affiliate.item_tag
    end
    counter
  end

protected

  def update_product_images product, values
    remote_image_path = product_remote_image(values)
    import_product_image(product, values, remote_image_path)
  end


  def import_product_image product, values, remote_image_path
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


    image = Magick::Image.read(trimmed_out).first
    # reduce number of colors
    quantized = image.quantize(1, Magick::RGBColorspace)
 
    # Create an image that has 1 pixel for each of the TOP_N colors.
    normal = sort_by_decreasing_frequency(quantized)
    rgb_color = get_pix(normal)
    average_color = colorname(rgb_color)
    brand = Colorization.where(name: average_color).first_or_create
    product.colorization_id = brand.id

    product.image = File.open(trimmed_out)
    product.save
    
    #cleanup
    File.delete(image_path) if File.exist?(image_path)
    File.delete(difference_path) if File.exist?(difference_path)
    File.delete(halo_mask) if File.exist?(halo_mask)
    File.delete(output_path) if File.exist?(output_path)
    File.delete(with_border) if File.exist?(with_border)
    File.delete(trimmed_out) if File.exist?(trimmed_out)

  end

  def update_product_attributes product, values
    product.name=product_name(values)
    product.number=product_number(values)
    product.description=product_description(values)
    brand = Brand.where(name: product_brand(values)).first_or_create
    product.brand_id = brand.id
    product.ean=product_ean(values)
    product.price=product_price(values)
    product.shippingHandlingCost=product_shipment_cost(values)
    product.lastModified=product_last_modified(values)
    product.deliveryTime=product_delivery_time(values)
    product.currencyCode=product_currency(values)
    product.deepLink=product_link(values)
    product
  end


  def update_product_categories(product, values)
    category = find_mapping(product_category(values))
    while category.present? do
      next if category.blank? 
      Categorization.where(product_id: product.id, category_id: category.id).first_or_create
      category = category.category
    end
  end

  def product_remote_image values
    image_tags = @affiliate.image_tag.split(',')
    for image_tag in image_tags
       result = values[image_tag.strip!] 
       return result if result.present?
    end
    nil
  end

  def product_link values
    values[@affiliate.link_tag]
  end

  def product_currency values
    values[@affiliate.currency_code_tag]
  end    

  def product_delivery_time values
    values[@affiliate.delivery_time_tag]
  end

  def product_last_modified values
    values[@affiliate.last_modified_tag]
  end

  def product_shipment_cost values
    values[@affiliate.shipping_cost_tag]
  end


  def product_price values
    values[@affiliate.price_tag]
  end

  def product_ean values
    values[@affiliate.ean_tag]
  end

  def product_brand values
    values[@affiliate.brand_tag]
  end

  def product_description values
    values[@affiliate.description_tag]
  end

  def product_number values
    values[@affiliate.number_tag]
  end


  def product_name values
    values[@affiliate.name_tag]
  end

  def product_brand values
    values[@affiliate.brand_tag]
  end

  def product_category values
    values[@affiliate.category_tag]
  end

  def product_last_modified values
    values[@affiliate.last_modified_tag]
  end

  def has_mapping name
    mapper[name].present?
  end

  def find_mapping name
    mapper[name]
  end

  def mapper
    @mapper = loadmapper
  end

  def loadmapper
    result = {}
    for mapping in @affiliate.mappings
      result[mapping.name] = mapping.category
    end
    result
  end 

  def document
    @document if @document.present?
    xml = open(@affiliate.file.path) {|f| f.read }
    source = XML::Parser.string(xml)
    @document = source.parse
  end

  def average_color(image)
    total = 0
    avg = { :r => 0.0, :g => 0.0, :b => 0.0 }

    image.quantize.color_histogram.each do |c,n|
      avg[:r] += n * c.red
      avg[:g] += n * c.green
      avg[:b] += n * c.blue
      total += n
    end

    avg.each_key do |c| 
      avg[c] /= total
      avg[c] = (avg[c] /  Magick::QuantumRange * 255).to_i
    end

    return [avg[:r],avg[:g],avg[:b]]
  end

  def colorname mycolor
    _colors = ["e7db9c", "ffff02", "7cfe6f", "ffdfef", 
               "ffdfef", "2ed0cd", "b9531c", "f4cb62", 
               "c61cd0", "ff0000", "ffffff", "2c2bd1", 
               "d4d4d4", "ffc702", "000000", "019e13", 
               "c5e1fd", "ff59ae", "77858f"]

    colors = []

    for _color in _colors
      colors << Color::RGB.from_html("#"+_color)
    end

    matcher = Color::RGB.from_html("#"+mycolor)

    matcher.closest_match(colors).html
  end


  def sort_by_decreasing_frequency(img)
    hist = img.color_histogram
    # sort by decreasing frequency
    sorted = hist.keys.sort_by {|p| -hist[p]}
    new_img = Magick::Image.new(hist.size, 1)
    new_img.store_pixels(0, 0, hist.size, 1, sorted)
  end
   
  def get_pix(img)
    pixels = img.get_pixels(0, 0, img.columns, 1)
    result = ""
    pixels.each do |p|
      result = p.to_color(Magick::AllCompliance, false, 8, true)
    end
    result
  end


  def convert_to_decimal_rgb hex
    components =  hex.scan(/.{2}/)
    rgb = [0,0,0]
    rgb[0] = components[0].to_i
    rgb[1] = components[0].to_i
    rgb[2] = components[0].to_i
    rgb
  end


  def clean_name name
    name.gsub('ö', 'oe').gsub('ü', 'ue').gsub('ä', 'ae').gsub('ß','ss').gsub('%', '').gsub(' ','_')
  end

end