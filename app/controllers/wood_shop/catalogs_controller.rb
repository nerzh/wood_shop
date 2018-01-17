module WoodShop
  class CatalogsController < ApplicationController
    before_action :define_object, only: [ :show ]

    def show
      @title                  = @object.title
      @description            = @object.description
      @keywords               = @object.keywords
      @name                   = @object.name.capitalize
      @categories             = @object.categories
    end

    private

    def define_object
      @object = Catalog.friendly.find(params[:id])
      if request.path != "/#{@object.slug}" and request.path != "/#{@object.slug}.json"
        redirect_to "/#{@object.slug}", status: :moved_permanently
      end
    end
  end
end