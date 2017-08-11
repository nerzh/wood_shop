class CreateWoodShopFiltersGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_filters_groups do |t|
      t.integer :group_id
      t.integer :filter_value_id

      t.timestamps
    end
  end
end
