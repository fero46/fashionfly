module Api::CatgegoriesHelper
  def category_icon category
    icons = category.icons.first
    result = icons.try(:image).try(:url)
    if result.present? && (result.start_with?("http://") || result.start_with?("https://"))
      request.protocol + request.host_with_port + result
    else
      result
    end
  end
end
