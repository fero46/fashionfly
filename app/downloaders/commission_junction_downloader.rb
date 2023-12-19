require 'net/http'

class CommissionJunctionDownloader < GenericDownloader
  def username
    '4473600'  # not valid anymore
  end

  def password
    '7_MxkuZ8' # not valid anymore
  end

  def temp
    'temp'
  end

  def temporary_path
    Rails.root.to_s + '/tmp/' + temp
  end

  def file_request
    uri = URI.parse(path)
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Get.new(uri.request_uri)
    req.basic_auth(username, password)
    http.request(req)
  end

  def download_file
    begin
      response = file_request
      File.open(temporary_path, 'wb') do |f|
        f.write response.body
      end
    end
    File.open(temporary_path) do |f|
      @affiliate.file = f
    end
  end
end
