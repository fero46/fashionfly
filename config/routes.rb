# frozen_string_literal: true

require 'sidekiq/web'

Fashionfly::Application.routes.draw do
  get 'app-entwickler-finden', to: 'redirector#appentwickler', as: 'app'
  get 'programmierer-hamburg', to: 'redirector#programmierer', as: 'prog'
  get 'internet-agentur-hamburg', to: 'redirector#internetagentur', as: 'int'

  get 'brandet_categories/show'

  get 'blogs/edit'

  get 'blogs/show'

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
    root to: 'dashboards#show'
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
                                    registrations: 'users/registrations' }

  resources :widgets

  namespace :endpoint do
    namespace :v1 do
      scope defaults: { format: 'json' } do
        resources :scopes, only: %i[index show] do
          resources :categories, only: %i[index show]
          resources :products, only: %i[index show]
          resources :collections_categories, only: %i[index show]
          resources :collections, except: :destroy do
            resources :comments
          end
          resources :users
          resources :session
        end
      end
    end
  end

  scope '/:locale' do
    get 'hashtags/:hashtag',   to: 'hashtags#show',      as: :hashtag
    get 'hashtags',            to: 'hashtags#index',     as: :hashtags
    resources :shops
    resources :banners
    resources :entries
    resources :brands, only: %i[show index]
    get 'property_shop_link', to: 'properties#property_shop_link', as: :property_shop_link
    get 'property_collection_link', to: 'properties#property_collection_link', as: :property_collection_link
    get 'property_category_link', to: 'properties#property_category_link', as: :property_category_link

    resource :property, only: %i[edit update]
    get 'shoplist', to: 'shops#list', as: :shoplist
    get 'shopref/:id', to: 'shops#ref', as: :shopref
    get 'language', to: 'welcome#language'
    resources :contests
    resources :styles, only: %i[show index]
    resources :profiles, only: %i[show update edit] do
      get 'outfits', to: 'profiles#outfits'
      get 'favorites', to: 'profiles#favorites'
      resource :blog
    end
    get '/product_clicked/:id', to: 'products#clicked', as: :prodclick
    patch 'email_edit', to: 'profiles#email_edit', as: :email_edit
    get 'prodref/:id', to: 'products#ref', as: :productref
    resources :products, only: %i[show index] do
      resources :favorites, only: %i[create destroy]
    end
    resources :collections, only: %i[show index] do
      resources :favorites, only: %i[create destroy]
      resources :comments, only: %i[create destroy update]
    end
    post 'product_partner', to: 'products#refshop', as: :refshop
    resources :categories
    resources :outfit_categories
    mount FashionFlyEditor::Engine => '/combine'
    namespace :api do
      match 'categories', to: 'categories#index', via: [:options]
      resources :categories
      resources :colors
      resources :products
    end
    get 'login', to: 'users#new', as: 'login'
    get 'faq', to: 'static#faq', as: 'faq'
    get 'about', to: 'static#about', as: 'about'
    get 'team', to: 'static#team', as: 'team'
    get 'disclaimer', to: 'static#disclaimer', as: 'disclaimer'
    get 'terms', to: 'static#terms', as: 'terms'
    get 'impress', to: 'static#impress', as: 'impress'
    get 'privacy', to: 'static#privacy', as: 'privacy'
    get 'sitemap.xml', to: 'welcome#sitemap', format: :xml, as: 'sitemap', defaults: { format: 'xml' }
    get 'robots.txt', to: 'welcome#robot', format: :text, as: 'robot', defaults: { format: 'text' }
    root 'welcome#index'
    get ':brand/:category', to: 'brandet_categories#show', as: 'brand_category'
  end

  # Parameter constraint checks if path does not begin with locale and only in that case redirects to localized version. This way we will avoid infinite redirects for non-existing urls.
  get '/*path', to: 'language#select', constraints: { path: %r{(?!(#{I18n.available_locales.join("|")})/).*} },
                format: false
end
