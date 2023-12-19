# frozen_string_literal: true

class AffiliateDownloader < GenericDownloader
  def publisher_id
    '704276' # not valid anymore
  end

  def password
    'khJtwzDyjLTIwoc32kwC' # not valid anymore
  end

  def download_file
    url = "http://productdata.download.affili.net/affilinet_products_#{program_id}_#{publisher_id}.zip?type=xml&auth=#{password}"
    @affiliate.remote_file_url = url
    @affiliate.save
  end
end
