class CartController < ApplicationController
  # include CartProcessor

  def show
    respond_to do |format|
      format.html do
      end

      format.json do
        render json: { sub_products:      get_array_products,
                       deliveries:        get_deliveries,
                       payments:          get_payments,
                       delivery_payments: get_delivery_payments,
                       cities:            get_cities }
      end
    end
  end

  def get_citys_streets
    citys_streets = City.find(params[:city_id]).streets
    render json: { streets: {values:     citys_streets,
                             with_limit: get_some_streets(citys_streets, params[:from], params[:limit]) }}
  end

  def get_users_address
    respond_to do |format|
      format.json do
        if current_user
          render(json: ActiveModelSerializers::SerializableResource
                           .new(AddressUser.find_by(user_id: current_user&.id), adapter: :json ).as_json)
        else
          render json: { address: [] }
        end
      end
    end
  end

  def create
    address, order, order_items = make_address_and_order

    if address.valid? and order.valid?
      order.address_order = address
      order.order_items   = order_items
      clear_cookie if order.save!
    else
      raise "VALIDATION ERROR. Order: #{order.errors.messages}\nAddress: #{address.errors.messages}"
    end
    head :ok
  end

  def update
  end

  def destroy
  end

  def add
  end

  private

  def params_cart
    params.require(:cart).permit(address: [:first_name, :last_name, :zip, :phone, :email],
                                 order: [:user_id, :delivery_id, :payment_id, :total_price],
                                 products: [[:amount, :price]])
  end
end