class WelcomeController < ScopeController

  protect_from_forgery with: :exception, except: 'language'

  def index
  end

  def sitemap
    path = Rails.root.join("public", "sitemaps", @scope.locale, "sitemap.xml")
    if File.exists?(path)
      render xml: open(path).read
    else
      render text: "Sitemap not found.", status: :not_found
    end
  end

  def language
    keys = Lit::LocalizationKey.where('localization_key like ?', 'fashion_fly_editor.%')
    map = {}
    for key in keys
      map[key.localization_key] = I18n.t(key.localization_key)
    end
    @translation = deflate_map(map)['fashion_fly_editor']
  end

  def robots
    respond_to :text
  end

private
  
  def deflate_map map
    new_map = {}
    for key in map.keys
      puts key
      value = map[key]
      list = key.split('.')
      temporary = new_map
      list.each_with_index do |item, index|
        if index == list.size - 1
          temporary[item] = value
        else
          temporary[item] = {} if temporary[item].blank?
        end
        temporary = temporary[item]
      end
    end
    puts new_map
    new_map
  end

end
