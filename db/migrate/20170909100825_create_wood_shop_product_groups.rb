class CreateWoodShopProductGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_product_groups do |t|
      t.integer :product_id
      t.integer :group_id

      t.timestamps
    end

    execute <<-SQL
      ALTER TABLE wood_shop_product_groups
        ADD CONSTRAINT wood_shop_product_groups_uniq_for_act_rec_import UNIQUE (product_id, group_id);
    SQL
  end
end
