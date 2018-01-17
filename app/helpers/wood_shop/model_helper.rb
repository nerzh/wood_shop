module WoodShop
  module ModelHelper
    # FriendlyId
    def should_generate_new_friendly_id?
      slug.blank? or url_changed?
    end

    def normalize_friendly_id(text)
      text.to_slug.normalize(transliterations: [:russian, :ukrainian]).to_s.gsub(/[^\w\s-]/, '')
    end
    # end FriendlyId

    def update_counters(klass)
      def get_array_assign_objects(arr)
        result = []
        arr.each do |obj|
          obj.assign_attributes({prod_count: obj.products.count})
          result << obj
        end
        result
      end

      WoodShop.const_get(klass.to_s.to_sym).import(get_array_assign_objects(WoodShop::Product.find(self.product_id).send(klass.to_s.downcase.pluralize.to_sym).group(:id)), on_duplicate_key_update: [:prod_count])
    end
  end
end