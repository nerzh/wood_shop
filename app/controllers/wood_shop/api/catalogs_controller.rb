module WoodShop
  class Api::CatalogsController < Api::ApplicationController
    def get_catalog_list
      render json: ActiveModelSerializers::SerializableResource.new(WoodShop::Catalog.all.order(:name),
                                                                    {group: params[:group].to_s.to_sym}).serializable_hash.to_json
    end

    def get_products
      render json: CatalogFilters.new(params, cookies: cookies, type: :catalog).execute.data_with_filters.to_json
    end
  end
end