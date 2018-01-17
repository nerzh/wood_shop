class CreateWoodShopBaseCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_base_codes do |t|
      t.integer :product_id
      t.integer :sub_product_id
      t.integer :vendor_id
      t.string  :vendor_sku
      t.string  :product_sku
      t.integer :price

      t.timestamps
    end

    execute <<-SQL
      ALTER TABLE wood_shop_base_codes ADD CONSTRAINT uniq_values_for_act_rec_import UNIQUE (vendor_id, vendor_sku, product_sku);
    SQL
  end
end
