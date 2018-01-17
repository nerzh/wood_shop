module WoodShop
  class Api::CitiesController < Api::ApplicationController
    def index
      render json: ActiveModelSerializers::SerializableResource.new(WoodShop::City.all.order(:description_ru),
                                                                    {group: params[:group].to_s.to_sym}).serializable_hash.to_json
    end
  end
end