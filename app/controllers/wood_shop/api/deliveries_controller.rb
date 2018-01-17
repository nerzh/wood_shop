module WoodShop
  class Api::DeliveriesController < Api::ApplicationController
    def index
      render json: ActiveModelSerializers::SerializableResource.new(Delivery.all,
                                                                    {group: :order}).serializable_hash.to_json
    end
  end
end