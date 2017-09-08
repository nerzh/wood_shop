module WoodShop
  class ProductsController < ApplicationController
    before_action :define_object, only: [ :show ]

    def index
      # @lists = current_user.lists
      # render json: @lists, only: [ :id, :name ], include:{ tasks:{ include:{ comments:{ include: { uploads: { only: [ :id, :name, :file_name ] } }, only: [ :id, :name ] } }, only: [ :id, :name, :sort_number, :done, :deadline ] } }
    end

    def show
      # @title       = @product.title
      # @description = @product.description
      # @keywords    = @product.keywords
      # @id          = @product.id
      # @name_page   = @product.name_page
      # @images      = @product.images
      # @price       = @product.price.to_price
      # # byebug
      # # @images.each { |el| @images.insert( 0, @images.delete(el) ) if el.primary }
      # @brand       = @product.brand
      # # group        = @product.group
      # @text        = @product.text
      # @doptext     = @product.doptext
      # # @name        = group.name
      # # allproducts  = group.products
      # @subproducts = {}
      # # @filters_product = FiltersProduct.includes(:filter, :value).select(:id, :product_id, :filter_id, :value_id)
      # #                                  .where(product_id: @product.id).order('filters.name')
    end

    private

    def define_object
      @object = WoodShop::Product.friendly.find(params[:id])
      if request.path != "/#{@object.slug}" and request.path != "/#{@object.slug}.json"
        redirect_to "/#{@object.slug}", status: :moved_permanently
      end
    end

    def params_product
      # params.require(:product).permit(:name)
    end


  end
end