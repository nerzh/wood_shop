class CreateWoodShopCitiesStreets < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_cities_streets do |t|
      t.integer :city_id
      t.integer :street_id

      t.timestamps
    end
  end
end
