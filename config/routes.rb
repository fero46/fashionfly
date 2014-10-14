Fashionfly::Application.routes.draw do

  namespace :backend do
    root :to => 'dashboards#show'
    resources :configurations
    resources :scopes
  end

  scope "/:locale", locale: /#{I18n.available_locales.join("|")}/ do
    resources :styles, only: [:show, :index]
    resources :products
    mount FashionFlyEditor::Engine => "/combine"
    namespace :api do
      resources :categories
      resources :colors
    end
    root 'welcome#index'
  end

  #Parameter constraint checks if path does not begin with locale and only in that case redirects to localized version. This way we will avoid infinite redirects for non-existing urls.
  get "/*path", to: 'language#select', constraints: {path: /(?!(#{I18n.available_locales.join("|")})\/).*/}, format: false

end
