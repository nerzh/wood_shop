module WoodShop
  class CategoriesController < ApplicationController
    before_action :define_object, only: [ :show ]

    def index
      @catalog    = Catalog.friendly.find(params[:catalog_id])
      @categories = @catalog.categories rescue raise('')
    rescue => ex
      render 'errors#internal_server_error'
    end

    def show
      @title       = @object.title
      @description = @object.description
      @keywords    = @object.keywords
      @name        = Unicode.capitalize(@object.name)
      # @products    = ActiveModelSerializers::SerializableResource.new(@object.products.includes(:image_products).limit(12),
      #                                                                 {each_serializer: WoodShop::ProductSerializer,
      #                                                                  group: :category}).serializable_hash
      # @catalogs    = ActiveModelSerializers::SerializableResource.new(Catalog.all,
      #                                                                 {each_serializer: WoodShop::CatalogSerializer,
      #                                                                  group: :for_category_list}).serializable_hash
      # @products = []
      # @categories = []
    end

    private

    def define_object
      @catalog  = Catalog.select(:id, :slug).find(params[:catalog_id]) rescue raise('')
      @object   = @catalog.categories.select(:id, :name, :title, :description, :keywords, :slug, :prod_count).find(params[:id]) rescue raise('')
    rescue => ex
      render 'errors#not_found'
    end
  end
end