module WoodShop
  ActiveAdmin.register Product, as: 'Product' do
    permit_params :id, :complex, :exist, :brand_id, :name, :min_price, :max_price, :text, :small_text, :url,
                  :slug, :title, :description, :keywords, :filterids, :filter_valueids, :sub_productids,
                  :sku_sub_products, :created_at, :updated_at, catalog_ids: [], category_ids: [], group_ids: []

    filter :id
    filter :catalog_in, as: :select, collection: -> { Catalog.all.order(name: :asc) }
    filter :category_in, as: :select, collection: -> { Category.all.order(name: :asc) }
    filter :group_in, as: :select, collection: -> { Group.all.order(name: :asc) }
    filter :exist
    filter :brand
    filter :name

    form do |f|
      inputs do
        f.input :id
        f.input :complex
        f.input :exist
        f.input :brand
        f.input :catalogs
        f.input :categories
        f.input :groups
        f.input :name
        f.input :min_price
        f.input :max_price
        f.input :text, as: :text
        f.input :small_text
        f.input :url
        f.input :slug
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