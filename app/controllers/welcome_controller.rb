# frozen_string_literal: true

class WelcomeController < ScopeController
  protect_from_forgery with: :exception, except: 'language'

  def index; end

  def sitemap
    path = Rails.root.join('public', 'sitemaps', @scope.locale, 'sitemap.xml')
    if File.exist?(path)
      render xml: open(path).read
    else
      render text: 'Sitemap not found.', status: :not_found
    end
  end

  def language
    keys = Lit::LocalizationKey.where('localization_key like ?', 'fashion_fly_editor.%')
    map = {}
    keys.each do |key|
      map[key.localization_key] = I18n.t(key.localization_key)
    end
    @translation = deflate_map(map)['fashion_fly_editor']
  end

  def robots
    respond_to :text
  end

  private

  def deflate_map(map)
    new_map = {}
    map.each_key do |key|
      puts key
      value = map[key]
      list = key.split('.')
      temporary = new_map
      list.each_with_index do |item, index|
        if index == list.size - 1
          temporary[item] = value
        elsif temporary[item].blank?
          temporary[item] = {}
        end
        temporary = temporary[item]
      end
    end
    puts new_map
    new_map
  end
end
