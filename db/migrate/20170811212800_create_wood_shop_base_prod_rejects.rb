class CreateWoodShopBaseProdRejects < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_base_prod_rejects do |t|
      t.integer :vendor_id
      t.string :name
      t.string :sku
      t.integer :price
      t.integer :category_id
      t.integer :group_id

      t.timestamps
    end
  end
end
