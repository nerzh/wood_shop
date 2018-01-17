module WoodShop
  class ProductsController < ApplicationController
    before_action :define_object, only: [ :show ]

    def show
      @title       = @object[:title]
      @description = @object[:description]
      @keywords    = @object[:keywords]
      @object      = ActiveModelSerializers::SerializableResource.new(@object, {group: :product}).serializable_hash
    end

    private

    def define_object
      @object = WoodShop::Product.friendly.find(params[:id])
      if request.path != "/#{@object[:slug]}" and request.path != "/#{@object[:slug]}.json"
        redirect_to "/#{@object[:slug]}", status: :moved_permanently
      end
    end
  end
end