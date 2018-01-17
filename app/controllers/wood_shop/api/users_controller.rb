module WoodShop
  class Api::UsersController < Api::ApplicationController
    def show
      render json: ActiveModelSerializers::SerializableResource.new(WoodShop::User.where(id: params[:id]),
                                                                    {group: params[:group].to_s.to_sym}).serializable_hash.to_json
    end
  end
end