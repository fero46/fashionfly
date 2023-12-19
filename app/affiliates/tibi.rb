# frozen_string_literal: true

class Tibi < CommissionJunctionDownloader
  def name
    'TIBI'
  end

  def temp
    'tibi.xml.gz'
  end

  def path
    'http://datatransfer.cj.com/datatransfer/files/4473600/outgoing/productcatalog/167902/Tibi_com-Tibi_Product_Catalog.xml.gz'
  end
end
