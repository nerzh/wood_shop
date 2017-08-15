class CreateFriendlyIdSlugs < ActiveRecord::Migration[5.1]
  def change
    create_table :wood_shop_friendly_id_slugs do |t|
      t.string   :slug,           :null => false
      t.integer  :sluggable_id,   :null => false
      t.string   :sluggable_type, :limit => 50
      t.string   :scope
      t.datetime :created_at
    end
    add_index :wood_shop_friendly_id_slugs, :sluggable_id, name: 'wood_shop_friendly_id_slugs_1'
    add_index :wood_shop_friendly_id_slugs, [:slug, :sluggable_type], length: { slug: 140, sluggable_type: 50 }, name: 'wood_shop_friendly_id_slugs_2'
    add_index :wood_shop_friendly_id_slugs, [:slug, :sluggable_type, :scope], length: { slug: 70, sluggable_type: 50, scope: 70 }, unique: true, name: 'wood_shop_friendly_id_slugs_3'
    add_index :wood_shop_friendly_id_slugs, :sluggable_type, name: 'wood_shop_friendly_id_slugs_4'
  end
end
