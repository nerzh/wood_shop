class CreateWoodShopStreets < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_streets do |t|
      t.string :description
      t.string :description_ru
      t.string :streets_type_ref
      t.string :streets_type

      t.timestamps
    end
  end
end
