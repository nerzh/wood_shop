class CreateWoodShopAreas < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_areas do |t|
      t.string :description
      t.string :description_ru
      t.string :ref
      t.string :city_center

      t.timestamps
    end
  end
end
