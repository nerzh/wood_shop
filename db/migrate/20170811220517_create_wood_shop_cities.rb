class CreateWoodShopCities < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_cities do |t|
      t.integer :area_id
      t.string :description
      t.string :description_ru
      t.string :ref
      t.boolean :delivery1
      t.boolean :delivery2
      t.boolean :delivery3
      t.boolean :delivery4
      t.boolean :delivery5
      t.boolean :delivery6
      t.boolean :delivery7

      t.timestamps
    end
  end
end
