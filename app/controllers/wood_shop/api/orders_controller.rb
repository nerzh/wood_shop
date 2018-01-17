module WoodShop
  class Api::OrdersController < Api::ApplicationController
    def show
    end

    def create
      @object = OrderFormObject.new(params: params, current_user: current_user)
      @object.apply_parameters
      if @object.save!
        render json: {response: 'success'}, status: 201
      else
        render json: {error: form.errors.messages}, status: 501
        method_complete = false
      end
    end
  end
end