module WoodShop
  ActiveAdmin.register ImageCategory, as: 'ImageCategory' do
    permit_params :category_id, :image, :alt, :primary, :order

    config.filters = false
  end
end