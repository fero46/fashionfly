# frozen_string_literal: true

class Breuninger < ZanoxDownloader
  def name
    'Breuninger.de Gesamtliste'
  end

  def path
    'http://productdata.zanox.com/exportservice/v1/rest/27961728C57589461.xml?ticket=D2806ABA3D821F26C1C378EF1B6DBA79&productIndustryId=1&gZipCompress=yes'
  end
end
