require 'csv'
require 'nokogiri'

file = ARGV[0]
tags = []
first = true
data = []
CSV.foreach(file,  {:col_sep => ","}) do |row|
  if first
    first = false
    tags = row
    next
  end
  data_row = {}
  row.each_with_index do |col, index|
    next if tags[index] == nil
    col = '' if col == nil
    data_row[tags[index]] = col
  end
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