class CreateWoodShopAddressOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_address_orders do |t|
      t.integer :order_id
      t.integer :area_id
      t.integer :city_id
      t.integer :street_id
      t.string :first_name
      t.string :last_name
      t.string :zip
      t.string :phone
      t.timestamp :date_start
      t.timestamp :date_finish
      t.string :email
      t.string :address
      t.integer :number_storage

      t.timestamps
    end
  end
end
