module WoodShop
  class BrandsController < ApplicationController
    before_action :define_brand, only: [:show]

    def index
      @brands     = Brand.all
      @characters = @brands.map{ |brand| Unicode.capitalize(brand.name[0]) }.uniq.sort
      respond_to do |format|
        format.html do
          @title       = 'Известные бренды парфюмерии, представленные в магазине inflavor.com.ua'
          @description = 'Список брендов парфюмерии и косметики'
          @keywords    = @brands.map{ |brand| Unicode.capitalize(brand.name) }.uniq.sort.join('; ')
        end

        format.json do
          render json: { brands:     ActiveModelSerializers::SerializableResource.new(@brands, adapter: :json).as_json,
                         characters: @characters }
        end
      end
    end

    def show
      respond_to do |format|
        format.html do
          @title              = @brand.title
          @description        = @brand.description
          @keywords           = @brand.keywords
        end

        format.json do
          query_object        = BrandsFilters.new(params, @brand){ cookies }
          @products           = query_object.products
          values              = query_object.hash_of_brand_filters(:sex, :obj, :type)
          arr_size            = values['obj'].map {|c| c['name'].to_i if c['name'].to_i != 0}.compact
          slider_size_minmax  = [arr_size.min, arr_size.max]
          slider_price_minmax = query_object.minmax_price_of_query

          render json: { products: ActiveModelSerializers::SerializableResource.new(@products, adapter: :json).as_json,
                         slider_size_minmax: slider_size_minmax, slider_price_minmax: slider_price_minmax,
                         values: values, all_product_count: query_object.all_product_count }
        end
      end
    end

    def define_brand
      @brand = Brand.friendly.find(params[:id])
      if request.path != "/#{@brand.slug}" and request.path != "/#{@brand.slug}.json"
        redirect_to "/#{@brand.slug}", status: :moved_permanently
      end
    end
  end
end