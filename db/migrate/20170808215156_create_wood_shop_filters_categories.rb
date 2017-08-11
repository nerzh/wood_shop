class CreateWoodShopFiltersCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_filters_categories do |t|
      t.integer :category_id
      t.integer :filter_value_id

      t.timestamps
    end
  end
end
