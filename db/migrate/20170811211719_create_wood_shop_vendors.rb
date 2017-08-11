class CreateWoodShopVendors < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_vendors do |t|
      t.string :name
      t.string :file
      t.string :formula
      t.integer :order
      t.integer :col_sku
      t.integer :col_name
      t.integer :col_price
      t.string :replace_if

      t.timestamps
    end
  end
end
