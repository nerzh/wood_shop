class CreateWoodShopFilterValues < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_filter_values do |t|
      t.integer :filter_id
      t.string :str_value
      t.float :num_value

      t.timestamps
    end
  end
end
