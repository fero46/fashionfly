require 'sidekiq/web'

Fashionfly::Application.routes.draw do

  admin_constraint = lambda do |request|
    current_user = request.env['warden'].user
    current_user.present? && current_user.respond_to?(:is_admin?) && current_user.is_admin?
  end

  team_constraint  = lambda do |request|
    current_user = request.env['warden'].user
    current_user.present? && current_user.respond_to?(:is_team?) && current_user.is_team?
  end


  post '/rate' => 'rater#create', :as => 'rate'
  constraints team_constraint do
      mount Lit::Engine => '/lit'
  end

  namespace :backend do
    constraints admin_constraint do
      mount Sidekiq::Web => '/sidekiq'
    end
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
                                    confirmations: 'users/confirmations',
                                    :registrations => "users/registrations"}

  resources :widgets

  scope "/:locale" do
    get "hashtags/:hashtag",   to: "hashtags#show",      as: :hashtag
    get "hashtags",            to: "hashtags#index",     as: :hashtags  
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
    get 'sitemap.xml', to: 'welcome#sitemap', format: :xml, as: 'sitemap', :defaults => { :format => 'xml' }
    get 'robots.txt', to: 'welcome#robot', format: :text, as: 'robot',:defaults => { :format => 'text' }
    root 'welcome#index'
  end

  #Parameter constraint checks if path does not begin with locale and only in that case redirects to localized version. This way we will avoid infinite redirects for non-existing urls.
  get "/*path", to: 'language#select', constraints: {path: /(?!(#{I18n.available_locales.join("|")})\/).*/}, format: false

end
