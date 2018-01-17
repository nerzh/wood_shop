module WoodShop
  ActiveAdmin.register Vendor, as: 'Vendor' do
    permit_params :name, :file, :formula, :order, :col_sku, :col_name, :col_price, :replace_if

    form do |f|
      inputs do
        f.input :name
        f.input :file
        f.input :formula, as: :text
        f.input :order
        f.input :col_sku
        f.input :col_name
        f.input :col_price
        f.input :replace_if, as: :select, collection: WoodShop::Vendor.replace_ifs.keys.map{|key| [key, key]}
        f.submit
      end
    end

    config.filters = false
  end
end