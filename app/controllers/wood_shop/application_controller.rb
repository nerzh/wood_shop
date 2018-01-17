module WoodShop
  class ApplicationController < ActionController::Base
    layout 'application' or layout 'wood_shop/application'
    # protect_from_forgery with: :exception
  end
end
