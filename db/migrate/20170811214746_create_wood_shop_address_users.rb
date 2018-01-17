class CreateWoodShopAddressUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_address_users do |t|
      t.integer :user_id
      t.integer :area_id
      t.integer :city_id
      t.integer :street_id
      t.string :first_name
      t.string :last_name
      t.string :zip
      t.string :phone
      t.string :address

      t.timestamps
    end
  end
end
