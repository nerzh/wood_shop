class CreateWoodShopSettlements < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_settlements do |t|
      t.integer :area_id
      t.string :description
      t.string :description_ru
      t.string :settlement_type_descr
      t.string :settlement_type_descr_ru
      t.string :region
      t.string :regions_descr
      t.string :regions_descr_ru
      t.string :ref_area
      t.string :area_descr
      t.string :area_descr_ru

      t.timestamps
    end
  end
end
