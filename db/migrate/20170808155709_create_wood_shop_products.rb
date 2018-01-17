class CreateWoodShopProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_products do |t|
      t.boolean :complex, default: false
      t.boolean :exist, default: false
      t.integer :brand_id
      t.string :name
      t.integer :min_price
      t.integer :max_price
      t.text :text
      t.string :small_text
      t.string :url
      t.string :slug
      t.string :title
      t.string :description
      t.string :keywords
      t.integer :filterids, array: true
      t.integer :filter_valueids, array: true
      t.integer :sub_productids, array: true
      t.string  :sku_sub_products, array: true

      t.timestamps
    end

    enable_extension "pg_trgm"
    execute 'CREATE INDEX name_trgm_idx ON wood_shop_products USING gin (name gin_trgm_ops);'
    execute 'CREATE INDEX text_trgm_idx ON wood_shop_products USING gin (text gin_trgm_ops);'

    add_index( :wood_shop_products, :exist )
    add_index( :wood_shop_products, :brand_id )
    add_index( :wood_shop_products, [:min_price, :max_price], order: {min_price: :asc} )
  end
end
