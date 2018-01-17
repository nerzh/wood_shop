WoodShop::Engine.routes.draw do
  WoodShop::Admin = Admin unless defined? WoodShop::Admin

  get 'errors/not_found'
  get 'errors/internal_server_error'
  match "/404", to: "errors#not_found",             via: :all
  match "/500", to: "errors#internal_server_error", via: :all

  devise_for :users, class_name: "WoodShop::User", module: :devise, controllers: {registrations: 'wood_shop/registration'}
  devise_for :admin_users, ActiveAdmin::Devise.config.merge( {class_name: "WoodShop::AdminUser"} )
  ActiveAdmin.routes(self)

  api_version(module: "Api", path: {:value => "api"}, default: true) do
    resources :catalogs, only: [] do
      collection do
        get 'get_catalog_list'
      end
      get 'get_products'
    end

    resources :categories, only: [:show] do
      get 'get_products'
    end

    resources :deliveries, only: [:index]
    resources :areas,      only: [:index]
    resources :cities,     only: [:index]
    resources :users,      only: [:show]
    resources :orders,     only: [:create]

    get 'cart/get_sub_products', to: 'cart#get_sub_products'
  end

  # CATEGORY = 'WoodShop::Category'
  # BRAND    = 'WoodShop::Brand'
  PRODUCT = 'WoodShop::Product' unless defined? PRODUCT
  CATALOG = 'WoodShop::Catalog' unless defined? CATALOG

  match '/:catalog_id/categories',     to: 'categories#index',  via: :get, as: 'categories'
  match '/:catalog_id/categories/:id', to: 'categories#show',   via: :get, as: 'category'
  match '/*id', to: 'catalogs#show',   constraints: MyRouteApp.new(CATALOG),  via: :get, as: 'catalog'
  match '/*id', to: 'products#show',   constraints: MyRouteApp.new(PRODUCT),  via: :get, as: 'product'
  # match '/*id', to: 'brands#show',     constraints: MyRouteApp.new(BRAND),    via: :get, as: 'brand'

  resources :users, only: [] do
    get 'orders'
    get 'profile'
    get 'address'
  end
  resources :brands, only: [:index, :show]
  resources :orders, only: [:new, :create, :update]
  resources :search, only: [:index]
end
