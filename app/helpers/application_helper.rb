module ApplicationHelper
  
  def field_class(resource, field_name)
    if resource.errors[field_name].present?
      return "error".html_safe
    else
      return "".html_safe
    end
  end

  def like_url
    require 'uri'
    URI.escape("http://crocodealia.de/")
  end

  def scope
    if params[:locale]
      (@scope ||= Scope.where(locale: locale).first)
    else
      get_right_scope
    end
  end


  def scoped_root_path
    if assigned_locale.present?
      root_path(locale: assigned_locale)
    else
      "/"
    end
  end


  def generate_name_and_flag code
    name = Country.new(code).name
    image_tag("flags/#{format_name(name)}.png") + I18n.t(code, :scope => :countries)
  end

private

  def format_name name=""
    name.downcase.gsub('\'', '').gsub(' ', '_').gsub('-','_')
  end

end
