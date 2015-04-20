module ApplicationHelper
  
  def show_exit_popup
    cookies['exit_popup'].blank?
  end


  def render_seo_block name
    if @scope.page(name).present?
      content_tag 'section', class: 's_textblock' do 
        content_tag 'div', class: 'container' do
          concat content_tag('h1', @scope.page(name).title) if @scope.page(name).title.present?
          concat simple_format @scope.page(name).body
        end
      end
    else
      content_tag 'div', '',id: name, style: 'display:none'
    end
  end

  def render_seo_blog user
    if user.is_blogger.present?
      content_tag 'section', class: 's_textblock' do 
        content_tag 'div', class: 'container' do
          concat content_tag('h1', user.blogging_feed.title) if user.blogging_feed.title.present?
          concat simple_format user.blogging_feed.description
        end
      end
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
    if @scope.facebook.present?
      URI.escape(@scope.facebook)
    else
      URI.escape(Settings.app.website)
    end
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

  def generate_name code
     I18n.t(code, :scope => :countries)
  end

  def social_footer_link network
    link = @scope.send(network)
    if link.present?
      link_to '', link, class: 'social', id:network.to_s, title: network.to_s, rel: 'publisher'
    end
  end

private

  def format_name name=""
    name.downcase.gsub('\'', '').gsub(' ', '_').gsub('-','_')
  end

end
