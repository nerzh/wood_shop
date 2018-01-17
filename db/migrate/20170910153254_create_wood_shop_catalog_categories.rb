class CreateWoodShopCatalogCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_catalog_categories do |t|
      t.integer :catalog_id
      t.integer :category_id

      t.timestamps
    end

    execute <<-SQL
      ALTER TABLE wood_shop_catalog_categories
        ADD CONSTRAINT wood_shop_catalog_categories_uniq_for_act_rec_import UNIQUE (catalog_id, category_id);
    SQL
  end
end
