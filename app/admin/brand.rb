ActiveAdmin.register WoodShop::Brand do
  permit_params :name, :text, :small_text, :url, :slug, :title, :description, :keywords
end