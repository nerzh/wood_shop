module WoodShop
  class OrderFormObject < SlimFormObject::Base
    validate :validation_models
    set_model_name('OrderForm')
    self.base_module = WoodShop
    init_models WoodShop::Order, WoodShop::OrderItem, WoodShop::AddressOrder
    not_save_empty_object_for WoodShop::Order

    def initialize(params: {}, current_user: nil)
      super(params: permit_params(params))
    end

    def permit_params(params)
      return {} if params.empty?
      params.require(:order_form).permit( order: [
                                            :delivery_id, :payment_id, :user_id, :description, :total_price, :aasm_state,
                                            order_item: [
                                              :order_id, :sub_product_id, :quantity, :price
                                            ]
                                          ],
                                          address_order: [
                                            :area_id, :city_id, :street_id, :first_name,
                                            :last_name, :phone, :address, :email, :number_storage,
                                            :date_start, :date_finish
                                          ]
                                    )
    end
  end
end