module WoodShop
  ActiveAdmin.register Brand, as: 'Brand' do
    permit_params :name, :text, :small_text, :url, :slug, :title, :description, :keywords
    config.filters = false
  end
end