require 'csv'
require 'nokogiri'

file = ARGV[0]

tags = ["ProductID","Name","MerchantID","Merchant","Link","Thumbnail","BigImage","Price","RetailPrice","Category","SubCategory","Description","Custom1","Custom2","Custom3","Custom4","Custom5","LastUpdated","status","manufacturer","partnumber","merchantCategory","merchantSubcategory","shortDescription","ISBN","UPC"]
USERID="1059452"

data = []
CSV.foreach(file,  {:col_sep => "|"}) do |row|
  data_row = {}
  row.each_with_index do |col, index|
    next if tags[index] == nil
    col = col.gsub('YOURUSERID', USERID) if col != nil
    col = '' if col == nil
    data_row[tags[index]] = col
  end
  data_row['currency'] = 'USD'
  data << data_row if data_row.size > 1
end

xml_out = Nokogiri::XML::Builder.new { |xml| 
    xml.products do
      data.each do |row|
        xml.product do 
          row.each do |k,v|
            xml.send(k.to_sym, v)
          end
        end
      end
    end
}.to_xml
output = file.gsub('.csv','')+".xml"
File.open(output, 'w') { |f| f.print(xml_out) }
puts 'FINISHED'