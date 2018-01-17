class CreateWoodShopVendors < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_vendors do |t|
      t.string :name
      t.string :file
      t.string :formula
      t.integer :order
      t.string :col_sku, default: 'A'
      t.string :col_name, default: 'C'
      t.string :col_price, default: 'D'
      t.string :replace_if, default: 'if_less'

      t.timestamps
    end
  end
end
