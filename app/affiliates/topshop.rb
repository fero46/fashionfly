# frozen_string_literal: true

class Topshop < ZanoxDownloader
  def name
    'TopShop'
  end

  def path
    'http://productdata.zanox.com/exportservice/v1/rest/30122119C955919797.xml?ticket=D2806ABA3D821F26C1C378EF1B6DBA79&productIndustryId=1&gZipCompress=yes'
  end
end
