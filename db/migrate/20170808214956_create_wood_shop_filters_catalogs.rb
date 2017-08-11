class CreateWoodShopFiltersCatalogs < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_filters_catalogs do |t|
      t.integer :catalog_id
      t.integer :filter_value_id

      t.timestamps
    end
  end
end
