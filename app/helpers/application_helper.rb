module ApplicationHelper
  def like_url
    require 'uri'
    URI.escape("http://crocodealia.de/")
  end

  def scope
    (@scope ||= Scope.where(locale: locale).first) if params[:locale]
  end
end
