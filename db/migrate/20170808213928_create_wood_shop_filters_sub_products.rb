class CreateWoodShopFiltersSubProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_filters_sub_products do |t|
      t.integer :sub_product_id
      t.integer :filter_value_id

      t.timestamps
    end
  end
end
