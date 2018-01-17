module WoodShop
  class Api::AreasController < Api::ApplicationController
    def index
      render json: ActiveModelSerializers::SerializableResource.new(WoodShop::Area.all.order(:description_ru),
                                                                    {group: params[:group].to_s.to_sym}).serializable_hash.to_json
    end
  end
end