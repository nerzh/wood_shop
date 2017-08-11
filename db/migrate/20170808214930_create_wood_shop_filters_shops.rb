class CreateWoodShopFiltersShops < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_filters_shops do |t|
      t.integer :shop_id
      t.integer :filter_value_id

      t.timestamps
    end
  end
end
