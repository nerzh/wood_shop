module WoodShop
  class ApplicationController < ActionController::Base
    # layout 'wood_shop/application'
    layout 'application'
    protect_from_forgery with: :exception
  end
end
