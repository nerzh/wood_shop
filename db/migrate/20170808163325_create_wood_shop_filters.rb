class CreateWoodShopFilters < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_filters do |t|
      t.string :name
      t.integer :values, array: true
      t.boolean :numeric, default: false
      t.integer :order

      t.timestamps
    end
  end
end
