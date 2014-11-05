require 'sidekiq/web'

Fashionfly::Application.routes.draw do

  namespace :backend do
    mount Sidekiq::Web => '/sidekiq'
    root :to => 'dashboards#show'
    resources :configurations
    resources :scopes do
      resources :categories
      resources :contests
      resources :affiliates do
        resources :mappings
      end
    end
  end

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  scope "/:locale", locale: /#{I18n.available_locales.join("|")}/ do
    resources :styles, only: [:show, :index]    
    resources :products do
      resources :favorites, only: [:create, :destroy]
    end
    resources :categories
    mount FashionFlyEditor::Engine => "/combine"
    namespace :api do
      match 'categories', to: 'categories#index', via: [:options]
      resources :categories
      resources :colors
      resources :products
    end
    get 'login',  to:'users#new', as: 'login'
    get "faq", to: 'static#faq', as: 'faq'
    get "terms", to: 'static#terms', as: 'terms'
    get "impress", to: 'static#impress', as: 'impress'
    get "privacy", to: 'static#privacy', as: 'privacy'

    root 'welcome#index'
  end

  #Parameter constraint checks if path does not begin with locale and only in that case redirects to localized version. This way we will avoid infinite redirects for non-existing urls.
  get "/*path", to: 'language#select', constraints: {path: /(?!(#{I18n.available_locales.join("|")})\/).*/}, format: false

end
