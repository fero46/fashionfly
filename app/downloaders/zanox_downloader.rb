# frozen_string_literal: true

class ZanoxDownloader < GenericDownloader
  def download_file
    @affiliate.remote_file_url = path
    @affiliate.save!
  end
end
