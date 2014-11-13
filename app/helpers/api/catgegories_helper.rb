module Api::CatgegoriesHelper
  def category_icon category
    icons = category.icons.first
    result = icons.try(:image).try(:url)
    result ? request.protocol + request.host_with_port + result : ""
  end
end
