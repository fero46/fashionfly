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
    @translation = I18n.t('fashion_fly_editor.').to_json()
  end

  def robots
    respond_to :text
  end
end
