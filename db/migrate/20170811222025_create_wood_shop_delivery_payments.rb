class CreateWoodShopDeliveryPayments < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_delivery_payments do |t|
      t.integer :delivery_id
      t.integer :payment_id

      t.timestamps
    end
  end
end
