module ApplicationHelper
  

  def render_seo_block name
    if @scope.page(name).present?
      content_tag 'section', class: 's_textblock' do 
        content_tag 'div', class: 'container' do
          content_tag('h1', @scope.page(name).title) if @scope.page(name).title.present?
          simple_format @scope.page(name).body
        end
      end
    else
      content_tag 'div', '',id: name, style: 'display:none'
    end
  end

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

  def social_footer_link network
    link = @scope.send(network)
    if link.present?
      link_to '', link, class: 'social', id:network.to_s, title: network.to_s
    end
  end

private

  def format_name name=""
    name.downcase.gsub('\'', '').gsub(' ', '_').gsub('-','_')
  end

end
