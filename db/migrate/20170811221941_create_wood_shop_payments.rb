class CreateWoodShopPayments < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_payments do |t|
      t.string :name
      t.string :payment_type
      t.string :description
      t.string :small_description
      t.integer :price

      t.timestamps
    end
  end
end
