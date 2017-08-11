WoodShop::Engine.routes.draw do
  WoodShop::Admin = Admin

  devise_for :users, class_name: "WoodShop::User", module: :devise
  devise_for :admin_users, ActiveAdmin::Devise.config.merge( {class_name: "WoodShop::AdminUser"} )
  ActiveAdmin.routes(self)

end
