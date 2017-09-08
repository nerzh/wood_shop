module WoodShop
  class CategoriesController < ApplicationController
    before_action :define_object, only: [ :show ]

    def index
      @categories = Catalog.friendly.find(params[:catalog_id]).categories rescue raise('')
    rescue => ex
      render 'errors#internal_server_error'
    end

    def show
      respond_to do |format|
        format.html do
          @title        = @object.title
          @description  = @object.description
          @keywords     = @object.keywords
          @name         = @object.name.capitalize
          @products     = @object.products.includes(:image_products).limit(12)
        end

        format.json do
          query_object            = CategoriesFilters.new(params, @category){ cookies }
          @products               = query_object.products
          values                  = query_object.hash_of_category_filters(:sex, :obj, :type)
          arr_size                = values['obj'].map {|c| c['name'].to_i if c['name'].to_i != 0}.compact

          slider_size_minmax     = [arr_size.min, arr_size.max]
          slider_price_minmax    = query_object.minmax_price_of_query

          render json: { products: ActiveModelSerializers::SerializableResource.new(@products, adapter: :json).as_json,
                         slider_size_minmax:  slider_size_minmax,
                         slider_price_minmax: slider_price_minmax,
                         values:              values,
                         all_product_count:   query_object.all_product_count }
        end
      end
    end

    private

    def define_object
      @object = Catalog.friendly.find(params[:catalog_id]).categories.find(params[:id]) rescue raise('')
    rescue => ex
      render 'errors#not_found'
    end
  end
end