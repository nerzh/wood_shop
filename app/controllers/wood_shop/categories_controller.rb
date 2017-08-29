class CategoriesController < ApplicationController

  before_action :define_category, only: [ :show ]

  def index
  end

  def show
    respond_to do |format|
      format.html do
        @title                  = @category.title
        @description            = @category.description
        @keywords               = @category.keywords
        @name                   = @category.name.capitalize
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

  def define_category
    @category = Category.friendly.find(params[:id])
    if request.path != "/#{@category.slug}" and request.path != "/#{@category.slug}.json"
      redirect_to "/#{@category.slug}", status: :moved_permanently
    end
  end
end