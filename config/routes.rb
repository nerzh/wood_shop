WoodShop::Engine.routes.draw do
  WoodShop::Admin = Admin

  devise_for :users, class_name: "WoodShop::User", module: :devise
  devise_for :admin_users, ActiveAdmin::Devise.config.merge( {class_name: "WoodShop::AdminUser"} )
  ActiveAdmin.routes(self)

  # get 'errors/not_found'
  # get 'errors/internal_server_error'
  #
  #
  # root to: 'index#index'

  # mount WoodShop::Engine, at: '/'

  resources :catalogs,   only: [:show]
  resources :categories, only: [:index, :show]
  resources :products,   only: [:show]
  resources :brands,     only: [:index, :show]

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

  match "/404", to: "errors#not_found",             via: :all
  match "/500", to: "errors#internal_server_error", via: :all

  CATALOG  = 'Catalog'
  CATEGORY = 'Category'
  PRODUCT  = 'Product'
  BRAND    = 'Brand'
  match '/*id', to: 'catalogs#show',   constraints: MyRouteApp.new(CATALOG), via: :get
  match '/*id', to: 'categories#show', constraints: MyRouteApp.new(CATEGORY), via: :get
  match '/*id', to: 'products#show',   constraints: MyRouteApp.new(PRODUCT),  via: :get
  match '/*id', to: 'brands#show',     constraints: MyRouteApp.new(BRAND),    via: :get
end
