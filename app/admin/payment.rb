module WoodShop
  ActiveAdmin.register Payment, as: 'Payment' do
    permit_params :name, :small_description, :description, :price, :payment_type

    config.filters = false
  end
end