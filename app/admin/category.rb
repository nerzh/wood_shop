module WoodShop
  ActiveAdmin.register Category, as: 'Category' do
    permit_params :name, :text, :small_text, :url, :slug,
                  :title, :description, :keywords, :filterids,
                  :filter_valueids, :prod_count, catalog_ids: [], group_ids: []

    form do |f|
      inputs do
        f.input :name
        f.input :catalogs
        f.input :groups
        f.input :text, as: :text
        f.input :small_text
        f.input :title
        f.input :description
        f.input :keywords
        f.submit
      end
    end

    config.filters = false
  end
end