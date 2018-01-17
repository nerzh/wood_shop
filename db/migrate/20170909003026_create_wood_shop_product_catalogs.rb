class CreateWoodShopProductCatalogs < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_product_catalogs do |t|
      t.integer :product_id
      t.integer :catalog_id

      t.timestamps
    end

    execute <<-SQL
      ALTER TABLE wood_shop_product_catalogs
        ADD CONSTRAINT wood_shop_product_catalogs_uniq_for_act_rec_import UNIQUE (product_id, catalog_id);
    SQL
  end
end
