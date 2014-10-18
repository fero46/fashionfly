 #encoding: utf-8 
require 'xml'
require 'fileutils'
require 'open-uri'


class ZanoxImporter


  def xml_list
    [
      #{ advertiser: "Kauf_Unique", file_url: "http://productdata.zanox.com/exportservice/v1/rest/28724438C74727101.xml?ticket=D2806ABA3D821F26C1C378EF1B6DBA79&gZipCompress=null"},
      #{ advertiser: "Mirabeau_versand", file_url: "http://productdata.zanox.com/exportservice/v1/rest/28724443C66903575.xml?ticket=D2806ABA3D821F26C1C378EF1B6DBA79&gZipCompress=null"},
    { advertiser: "Karen_Miller", file_url: "http://productdata.zanox.com/exportservice/v1/rest/28724417C45114353.xml?ticket=D2806ABA3D821F26C1C378EF1B6DBA79&gZipCompress=null"},
    { advertiser: "phillip_plein", file_url: "http://productdata.zanox.com/exportservice/v1/rest/28724455C44315366.xml?ticket=D2806ABA3D821F26C1C378EF1B6DBA79&gZipCompress=null"},
    { advertiser: "Dawanda", file_url: "http://productdata.zanox.com/exportservice/v1/rest/28724462C34773720.xml?ticket=D2806ABA3D821F26C1C378EF1B6DBA79&gZipCompress=null"},
    { advertiser: "mirapodo", file_url: "http://productdata.zanox.com/exportservice/v1/rest/28723785C81010184.xml?ticket=D2806ABA3D821F26C1C378EF1B6DBA79&gZipCompress=null"},
    { advertiser: "wardow", file_url: "http://productdata.zanox.com/exportservice/v1/rest/28724471C28815849.xml?ticket=D2806ABA3D821F26C1C378EF1B6DBA79&gZipCompress=null"},
    { advertiser: "joop", file_url: "http://productdata.zanox.com/exportservice/v1/rest/28724473C39642302.xml?ticket=D2806ABA3D821F26C1C378EF1B6DBA79&gZipCompress=null"},
    { advertiser: "esprit", file_url: "http://productdata.zanox.com/exportservice/v1/rest/28724477C79684775.xml?ticket=D2806ABA3D821F26C1C378EF1B6DBA79&gZipCompress=null"},
    { advertiser: "superdry", file_url: "http://productdata.zanox.com/exportservice/v1/rest/28724478C79510495.xml?ticket=D2806ABA3D821F26C1C378EF1B6DBA79&gZipCompress=null"},
    { advertiser: "impressions", file_url: "http://productdata.zanox.com/exportservice/v1/rest/28724482C50023966.xml?ticket=D2806ABA3D821F26C1C378EF1B6DBA79&gZipCompress=null"},
    { advertiser: "promod", file_url: "http://productdata.zanox.com/exportservice/v1/rest/28724483C85467518.xml?ticket=D2806ABA3D821F26C1C378EF1B6DBA79&gZipCompress=null"},
    { advertiser: "breuniger", file_url: "http://productdata.zanox.com/exportservice/v1/rest/27961728C57589461.xml?ticket=D2806ABA3D821F26C1C378EF1B6DBA79&gZipCompress=null"},
    { advertiser: "jades", file_url: "http://productdata.zanox.com/exportservice/v1/rest/27965103C8770737.xml?ticket=D2806ABA3D821F26C1C378EF1B6DBA79&gZipCompress=null"},
    { advertiser: "Christ", file_url: "http://productdata.zanox.com/exportservice/v1/rest/28724479C97523952.xml?ticket=D2806ABA3D821F26C1C378EF1B6DBA79&gZipCompress=null"}]
  end


  def sync_product zone, attributes, values

    product = Product.where(affi_shop: zone, affi_code: attributes['zupid']).first_or_create
    return if product.lastModified==values['lastModified']

    categories = values['merchantCategory']
    categorie_names = []
    if categories.present?
      categorie_names = categories.split("/")
      categorie_names = categorie_names[0] if categorie_names..kind_of?(Array) && categorie_names.length == 0
      categorie_names = categories.split(">") if categorie_names.is_a? String
      categorie_names = [categorie_names] if categorie_names.is_a? String
      categorie_names.each { |n| n.strip!} 
    end
    category_id=nil
    catorie_ids = []
    for category_name in categorie_names
      category= Category.where(name: category_name, category_id: category_id).first_or_create
      category_id = category.id
      catorie_ids << category_id
      category.save
    end

    full_path_to_tmp = Rails.root.to_s + "/tmp/"
    image_path = full_path_to_tmp+'image.png'
    difference_path = full_path_to_tmp+'difference.png'
    halo_mask = full_path_to_tmp + "halo.png"
    output_path = full_path_to_tmp+'out.png'
    remote_image_path = values['largeImage']

    remote_image_path = values[:mediumImage] if remote_image_path == nil


    return if remote_image_path == nil


    File.open(image_path, "wb") do |saved_file|
      # the following "open" is provided by open-uri
      open(remote_image_path, "rb") do |read_file|
        saved_file.write(read_file.read)
      end
    end

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

    system alpha_command
    system halo_command
    system result_command

    image = Magick::Image.read(output_path).first
    # reduce number of colors
    quantized = image.quantize(1, Magick::RGBColorspace)
 
    # Create an image that has 1 pixel for each of the TOP_N colors.
    normal = sort_by_decreasing_frequency(quantized)
    rgb_color = get_pix(normal)
    average_color = colorname(rgb_color)
    brand = Colorization.where(name: average_color).first_or_create
    product.colorization_id = brand.id


    product.image = File.open(output_path)

    product.name=values['name']
    product.number=values['number']
    product.description=values['description']
    brand = Brand.where(name: values['manufacturer']).first_or_create
    product.brand_id = brand.id
    product.ean=values['ean']
    product.price=values['price']
    product.shippingHandlingCost=values['shippingHandlingCost']
    product.lastModified=values['lastModified']
    product.deliveryTime=values['deliveryTime']
    product.currencyCode=values['currencyCode']
    product.deepLink=values['deepLink']

    product.save
    product.original = File.open(image_path)
    product.save!

    puts "Save"

    Categorization.where(product_id: product.id).destroy_all

    for cat_id in catorie_ids
      Categorization.where(category_id: cat_id, product_id: product.id).first_or_create
    end
  end


  def run
    for xml in xml_list
      file = xml[:advertiser]
      url = xml[:file_url]
      mycontent = open(url) {|f| f.read }
      puts "Load Content"
      source = XML::Parser.string(mycontent)

      doc = source.parse
      counter = 0
      puts "Starte Import"
      doc.root.children.each do |p|
        if p.name == "product"
          attributes = {}
          p.attributes.each do |a|
            attributes[a.name] = a.value
          end
          values = {}
          p.children.each do |t|
            values[t.name] = t.content
          end
          sync_product(file, attributes, values)
        end
        counter+=1
      end
      puts "#{url} - #{counter} Produkte"
    end
  end

  def count
    files = %w(breuninger jade24)
    for file in files
      filename = Rails.root+"#{file}.xml"
      xml = File.read(filename)
      source = XML::Parser.string(xml)
      doc = source.parse
      counter = 0
      doc.root.children.each do |p|
        counter+=1
      end
      puts "#{filename} - #{counter} Produkte"
    end
  end


  def update_categories parent=nil, parent_slug=""
    categories = Category.where(category_id: parent)
    parent_slug = parent_slug + "-" if parent_slug != ""
    for category in categories
      slug = parent_slug + category.name.try(:downcase)
      category_id = category.id
      slug = clean_name(slug) if slug.present?
      category.slug= slug
      category.save
      update_categories(category_id, slug)
    end
  end


private

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