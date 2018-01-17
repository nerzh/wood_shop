class CreateWoodShopProductCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_product_categories do |t|
      t.integer :product_id
      t.integer :category_id

      t.timestamps
    end

    execute <<-SQL
      ALTER TABLE wood_shop_product_categories
        ADD CONSTRAINT wood_shop_product_categories_uniq_for_act_rec_import UNIQUE (product_id, category_id);
    SQL
  end
end
