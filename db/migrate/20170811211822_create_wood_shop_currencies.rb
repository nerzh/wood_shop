class CreateWoodShopCurrencies < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_currencies do |t|
      t.string :name
      t.integer :value
      t.boolean :primary

      t.timestamps
    end
  end
end
