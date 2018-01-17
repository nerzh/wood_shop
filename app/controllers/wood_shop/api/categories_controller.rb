module WoodShop
  class Api::CategoriesController < Api::ApplicationController
    def get_products
      render json: CatalogFilters.new(params, cookies: cookies, type: :category).execute.data_with_filters.to_json
    end
  end
end