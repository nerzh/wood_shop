class CreateWoodShopCatalogProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_catalog_products do |t|
      t.integer :catalog_id
      t.integer :category_id
      t.integer :group_id
      t.integer :product_id

      t.timestamps
    end
  end
end
