class ProductsController < ApplicationController

  before_action :define_product, only: [ :show ]

  def index
    # @lists = current_user.lists
    # render json: @lists, only: [ :id, :name ], include:{ tasks:{ include:{ comments:{ include: { uploads: { only: [ :id, :name, :file_name ] } }, only: [ :id, :name ] } }, only: [ :id, :name, :sort_number, :done, :deadline ] } }
  end

  def show
    @title       = @product.title
    @description = @product.description
    @keywords    = @product.keywords
    @id          = @product.id
    @name_page   = @product.name_page
    @images      = @product.images
    @price       = @product.price.to_price
    # byebug
    # @images.each { |el| @images.insert( 0, @images.delete(el) ) if el.primary }
    @brand       = @product.brand
    # group        = @product.group
    @text        = @product.text
    @doptext     = @product.doptext
    # @name        = group.name
    # allproducts  = group.products
    @subproducts = {}
    @filters_product = FiltersProduct.includes(:filter, :value).select(:id, :product_id, :filter_id, :value_id)
                                     .where(product_id: @product.id).order('filters.name')
    #
    # allproducts.each do |prod|
    #   prod.sub_products.includes(:filters, :values, :product).each do |subprod|
    #     if prod.id == @product.id
    #       obj  = :none
    #       sex  = :none
    #       type = :none
    #       sign = :none
    #
    #       basestr = subprod.filters_sub_products
    #       basestr.each { |str| obj  = str.value.name if str.filter_id == 1 }
    #       basestr.each { |str| sex  = str.value.name if str.filter_id == 2 }
    #       basestr.each { |str| sign = str.value.sign; type = str.value.name if str.filter_id == 3 }
    #
    #       @subproducts[:current] ||= []
    #       @subproducts[:current] << {id: subprod.id, name: @name, obj: obj, sex: sex,
    #                                  type: type, sign: sign, price: subprod.price.to_price.round}
    #     else
    #       obj  = :none
    #       sex  = :none
    #       type = :none
    #       sign = :none
    #
    #       basestr = subprod.filters_sub_products
    #       basestr.each { |str| obj  = str.value.name if str.filter_id == 1 }
    #       basestr.each { |str| sex  = str.value.name if str.filter_id == 2 }
    #       basestr.each { |str| sign = str.value.sign; type = str.value.name if str.filter_id == 3 }
    #
    #       @subproducts[:dop]       ||= {}
    #       @subproducts[:dop][sign] ||= []
    #       @subproducts[:dop][sign] << {id: subprod.id, name: @name, obj: obj, sex: sex,
    #                                    type: type, sign: sign, price: subprod.price.to_price.round}
    #     end
    #   end
    # end
    #
    # @subproducts[:current].sort! { |x, y| x[:obj].to_i <=> y[:obj].to_i }
    # @subproducts[:dop].keys do |key|
    #   @subproducts[:dop][key].sort! { |x, y| x[:obj].to_i <=> y[:obj].to_i }
    # end unless @subproducts[:dop] == nil
  end

  private

  def define_product
    @product = Product.friendly.find(params[:id])
    if request.path != "/#{@product.slug}" and request.path != "/#{@product.slug}.json"
      redirect_to "/#{@product.slug}", status: :moved_permanently
    end
  end

  def params_product
    # params.require(:product).permit(:name)
  end


end