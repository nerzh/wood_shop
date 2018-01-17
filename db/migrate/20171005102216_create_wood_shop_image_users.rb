class CreateWoodShopImageUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_image_users do |t|
      t.string :image
      t.integer :user_id
      t.string :alt
      t.boolean :primary
      t.integer :order

      t.timestamps
    end
  end
end
