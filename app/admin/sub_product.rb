module WoodShop
  ActiveAdmin.register SubProduct, as: 'SubProduct' do
    permit_params :exist, :product_id, :brand_id, :vendor_id, :price, :sku, :name, :text, :small_text, :title,
                  :description, :keywords, :filterids, :filter_valueids, :created_at, :updated_at

    filter :id
    filter :product_in, as: :number
    filter :exist
    filter :brand
    filter :vandor
    filter :price
    filter :name

    form do |f|
      inputs do
        f.input :id
        f.input :exist
        f.input :product_id
        f.input :vendor
        f.input :brand
        f.input :price
        f.input :sku
        f.input :name
        f.input :text, as: :text
        f.input :small_text
        f.input :title
        f.input :description
        f.input :keywords
        f.input :created_at
        f.input :updated_at
        f.submit
      end
    end
  end
end