module WoodShop
  class Api::ProductsController < Api::ApplicationController
    def index
      render json: CatalogFilters.new(params, cookies).products_as_json.to_json
    end
  end
end