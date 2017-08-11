class CreateWoodShopOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_orders do |t|
      t.integer :user_id
      t.integer :delivery_id
      t.integer :payment_id
      t.integer :address_order_id
      t.integer :coupon_id
      t.integer :total_price
      t.string :aasm_state

      t.timestamps
    end
  end
end
