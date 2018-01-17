module WoodShop
  class Api::CartController < Api::ApplicationController
    def get_sub_products
      render json: ActiveModelSerializers::SerializableResource.new(WoodShop::SubProduct.where(id: params[:sub_product_ids]),
                                                                    {group: params[:group].to_s.to_sym}).serializable_hash.to_json
    end
  end
end