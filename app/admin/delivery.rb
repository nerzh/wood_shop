module WoodShop
  ActiveAdmin.register Delivery, as: 'Delivery' do
    permit_params :name, :small_description, :description, :price, :delivery_type

    config.filters = false
  end
end