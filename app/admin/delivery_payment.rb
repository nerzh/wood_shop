module WoodShop
  ActiveAdmin.register DeliveryPayment, as: 'DeliveryPayment' do
    permit_params :delivery_id, :payment_id

    config.filters = false
  end
end