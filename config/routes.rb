WoodShop::Engine.routes.draw do
  WoodShop::Admin = Admin unless defined? WoodShop::Admin

  devise_for :users, class_name: "WoodShop::User", module: :devise
  devise_for :admin_users, ActiveAdmin::Devise.config.merge( {class_name: "WoodShop::AdminUser"} )
  ActiveAdmin.routes(self)

  scope :api do
    api_version(module: "Api::v1", path: {:value => "v1"}, default: true) do

    end
  end

  root to: 'index#index'

  scope :api do
    api_version(module: "Api::v1", path: {:value => "v1"}, default: true) do
    end
  end

  # resources :update do
  #   collection do
  #     post 'upload'
  #   end
  # end
  #
  # resources :products do
  #   member do
  #   end
  # end
  #
  # resource  :cart, controller: 'cart', only: [:show, :create, :update, :destroy] do
  #   collection do
  #     get  'get_citys_streets'
  #     get  'get_users_address'
  #   end
  # end

  # CATALOG  = 'WoodShop::Catalog'
  # CATEGORY = 'WoodShop::Category'
  # match '/*id', to: 'catalogs#show',   constraints: MyRouteApp.new(CATALOG), via: :get
  # match '/*id', to: 'categories#show', constraints: MyRouteApp.new(CATEGORY), via: :get
  PRODUCT = 'WoodShop::Product' unless defined? PRODUCT
  # BRAND    = 'WoodShop::Brand'
  match '/:catalog_id/categories',     to: 'categories#index',  via: :get, as: 'categories'
  match '/:catalog_id/categories/:id', to: 'categories#show',   via: :get, as: 'category'
  match '/*id', to: 'products#show',   constraints: MyRouteApp.new(PRODUCT),  via: :get, as: 'product'
  # match '/*id', to: 'brands#show',     constraints: MyRouteApp.new(BRAND),    via: :get, as: 'brand'

  resources :brands,     only: [:index, :show]

  get 'errors/not_found'
  get 'errors/internal_server_error'
  match "/404", to: "errors#not_found",             via: :all
  match "/500", to: "errors#internal_server_error", via: :all
end
