class CreateWoodShopBrands < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_brands do |t|
      t.string :name
      t.text :text
      t.string :small_text
      t.string :url
      t.string :slug
      t.string :title
      t.string :description
      t.string :keywords

      t.timestamps
    end
  end
end
