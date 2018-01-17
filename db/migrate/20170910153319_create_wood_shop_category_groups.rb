class CreateWoodShopCategoryGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_category_groups do |t|
      t.integer :category_id
      t.integer :group_id

      t.timestamps
    end

    execute <<-SQL
      ALTER TABLE wood_shop_category_groups
        ADD CONSTRAINT wood_shop_category_groups_uniq_for_act_rec_import UNIQUE (category_id, group_id);
    SQL
  end
end
