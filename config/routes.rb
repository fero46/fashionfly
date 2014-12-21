require 'sidekiq/web'

Fashionfly::Application.routes.draw do
  #mount Lit::Engine => '/lit'
  get "outfit_categories/index"
  post '/rate' => 'rater#create', :as => 'rate'
  namespace :backend do
    mount Sidekiq::Web => '/sidekiq'
    root :to => 'dashboards#show'
    resources :configurations
    resources :scopes do
      resources :outfit_categories
      resources :categories
      resources :contests
      resources :pages
      resources :affiliates do
        resources :mappings
      end
    end
  end

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
                                    confirmations: 'users/confirmations' }

  resources :widgets

  scope "/:locale", locale: /#{I18n.available_locales.join("|")}/ do
    resources :contests
    resources :styles, only: [:show, :index]
    resources :profiles, only:[:show, :update, :edit]
    patch 'email_edit', to: 'profiles#email_edit', as: :email_edit
    resources :products, only: [:show, :index] do
      resources :favorites, only: [:create, :destroy]
    end
    resources :collections, only: [:show, :index] do
      resources :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy, :update]
    end
    post 'product_partner', to:'products#refshop', as: :refshop
    resources :categories
    resources :outfit_categories
    mount FashionFlyEditor::Engine => "/combine"
    namespace :api do
      match 'categories', to: 'categories#index', via: [:options]
      resources :categories
      resources :colors
      resources :products
    end
    get 'login',  to:'users#new', as: 'login'
    get "faq", to: 'static#faq', as: 'faq'
    get 'about', to: 'static#about', as: 'about'
    get 'team', to: 'static#team', as: 'team'
    get 'disclaimer', to: 'static#disclaimer', as: 'disclaimer'
    get "terms", to: 'static#terms', as: 'terms'
    get "impress", to: 'static#impress', as: 'impress'
    get "privacy", to: 'static#privacy', as: 'privacy'
    root 'welcome#index'
  end

  #Parameter constraint checks if path does not begin with locale and only in that case redirects to localized version. This way we will avoid infinite redirects for non-existing urls.
  get "/*path", to: 'language#select', constraints: {path: /(?!(#{I18n.available_locales.join("|")})\/).*/}, format: false

end
