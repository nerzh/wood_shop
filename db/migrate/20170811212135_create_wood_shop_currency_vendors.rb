class CreateWoodShopCurrencyVendors < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_currency_vendors do |t|
      t.integer :currency_id
      t.integer :vendor_id
      t.float :value
      t.boolean :primary

      t.timestamps
    end
  end
end
