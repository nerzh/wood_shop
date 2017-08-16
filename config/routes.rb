WoodShop::Engine.routes.draw do
  WoodShop::Admin = Admin

  devise_for :users, class_name: "WoodShop::User", module: :devise
  devise_for :admin_users, ActiveAdmin::Devise.config.merge( {class_name: "WoodShop::AdminUser"} )
  ActiveAdmin.routes(self)

  scope :api do
    api_version(module: "Api::v1", path: {:value => "v1"}, default: true) do
      # resources :agencies,            only: [:index, :show, :create]
      # resources :agency_services,     only: [:show]
      # resources :user_files,          only: [:index, :create, :delete]
      # resources :user_step_chains,    only: [:index, :update]
      # resources :vacancies,           only: [:index, :create]
      # resources :ovirs,               only: [:index, :create]
      # resources :banks,               only: [:index, :create]
      # resources :cities,              only: [:index, :show]
      # resources :areas,               only: [:index, :show]
      # resources :chains,              only: [:index]
      # resources :billings,            only: [:index, :create, :update]
      # resources :promo_codes,         only: [:index, :update]
      # resources :category_vacancies,  only: [:index]
      # resources :specialty_vacancies, only: [:index]
      #
      # get 'promo_codes/check_promo_code', to: 'promo_codes#check_promo_code'
    end
  end



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

  CATALOG  = 'Catalog'
  CATEGORY = 'Category'
  PRODUCT  = 'Product'
  BRAND    = 'Brand'
  match '/*id', to: 'catalogs#show',   constraints: MyRouteApp.new(CATALOG), via: :get
  match '/*id', to: 'categories#show', constraints: MyRouteApp.new(CATEGORY), via: :get
  match '/*id', to: 'products#show',   constraints: MyRouteApp.new(PRODUCT),  via: :get
  match '/*id', to: 'brands#show',     constraints: MyRouteApp.new(BRAND),    via: :get

  get 'errors/not_found'
  get 'errors/internal_server_error'
  match "/404", to: "errors#not_found",             via: :all
  match "/500", to: "errors#internal_server_error", via: :all
end
