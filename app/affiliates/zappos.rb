# frozen_string_literal: true

class Zappos < CommissionJunctionDownloader
  def name
    'Zappos'
  end

  def temp
    'zappos.xml.gz'
  end

  def path
    'http://datatransfer.cj.com/datatransfer/files/4473600/outgoing/productcatalog/168686/Zappos_com-Style_Level_Feed.xml.gz'
  end
end
