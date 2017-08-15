class CreateWoodShopBaseCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_base_codes do |t|
      t.integer :sub_product_id
      t.integer :vendor_id
      t.string  :sku
      t.integer :price

      t.timestamps
    end
  end
end
