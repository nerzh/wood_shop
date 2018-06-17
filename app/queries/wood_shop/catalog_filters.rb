module WoodShop
  class CatalogFilters
    attr_reader :data

    def initialize(params, cookies: {}, type: :catalog)
      @params        = params
      @cookies       = cookies
      @type          = type
      @catalog_id    = params[:catalog_id]
      @category_id   = params[:category_id]
      @page          = params[:page] ? params[:page] : 1
      @per           = cookies[:per] ? cookies[:per] : 12
      @sort          = cookies[:sort] ? cookies[:sort] : 'price_asc'
      @filters       = filters_params['filters'] ? filters_params['filters'] : {}
      @price         = params[:price] ? params[:price] : {}
      @data          = {}
      klass()
      slug()
    end

    def execute
      execute_queries
      self
    end

    def products
      Kaminari.paginate_array(all_products).page(@page).per(@per)
    end

    def data_with_filters
      @data.merge!({filters: make_filters})
      @data.merge!({prods: products_as_json})
    end

    private

    def products_as_json
      prods   = Kaminari.paginate_array(sort_products(@all_products)).page(@page).per(@per)
      pages   = prods.total_pages
      options = {group: :catalog, pages: pages}
      ActiveModelSerializers::SerializableResource.new(prods, options).serializable_hash
    end

    def execute_queries
      @all_products = all_products
      @all_products = filter_groups(@all_products)
      @all_products = filter_price(@all_products)
      @all_products = string_filters(@all_products)
      @all_products = numeric_filters(@all_products)
      @all_products.group(:id).order(:desc)
    end

    def define_object
      @klass.find(@slug)
    end

    def all_products
      define_object.products
    end

    def string_filters(prods)
      if get_string_filter_ids.empty?
        prods
      else
        prods = prods.where("wood_shop_products.filter_valueids @> ARRAY[#{get_string_filter_ids.join(',')}]")
      end
      prods
    end

    def get_string_filter_ids
      ids = []
      @filters.each do |name, hash|
        next if hash['id'].to_i == -1
        ids += hash['value_ids'] unless hash['numeric']
      end
      ids
    end

    def numeric_filters(prods)
      @filters.each do |name, hash|
        if hash['numeric']
          next if hash['id'].to_i == 0
          valueids = WoodShop::Filter.find(hash['id'].to_i).filter_values.where("wood_shop_filter_values.num_value >= #{hash['min']}
               and wood_shop_filter_values.num_value <= #{hash['max']}").pluck(:id)
          prods    = prods.where("wood_shop_products.filter_valueids @> ARRAY#{valueids.to_s}")
        end
      end
      prods
    end

    def filter_price(prods)
      @filters.each do |name, hash|
        if hash['id'].to_i == 0
          prods = prods.where("wood_shop_products.min_price >= #{hash['min'].to_cent}
               and wood_shop_products.max_price <= #{hash['max'].to_cent}")
          break
        end
      end
      prods
    end

    def filter_groups(prods)
      @filters.each do |name, hash|
        if hash['id'].to_i == -1
          prods = prods.joins(:product_groups).where('wood_shop_product_groups.group_id' => hash['value_ids']).group(:id)
          break
        end
      end
      prods
    end

    def make_filters
       make_price_filter + make_group_filter + get_filters
    end

    def make_price_filter
      [
          {id: 0, name: 'Цена', numeric: true, order: 0,
           min: get_catalog_max_min_price[:min], max:  get_catalog_max_min_price[:max],
           min_start: get_start_max_min_price[:min], max_start: get_start_max_min_price[:max]}
      ]
    end

    def make_group_filter
      [
          {id: -1, name: 'Группа', numeric: false, order: -1, filter_values: get_groups}
      ]
    end

    def get_catalog_max_min_price
      max_min = all_products.select('min(wood_shop_products.min_price) as min, max(wood_shop_products.max_price) as max')
      { min: (max_min[0].min&.to_price or 0), max: (max_min[0].max&.to_price or 0)}
    end

    def get_start_max_min_price
      max_min = WoodShop::Product
                    .where(id: @all_products)
                    .select('min(wood_shop_products.min_price) as min, max(wood_shop_products.max_price) as max')
      { min: (max_min[0].min&.to_price or 0), max: (max_min[0].max&.to_price or 0)}
    end

    def get_filters
      return @all_products if @all_products.empty?
      prods   = WoodShop::Filter.joins(filter_values: :products).where('wood_shop_products.id' => @all_products).group(:id)
      options = {group: :catalog, prods: prods}
      ActiveModelSerializers::SerializableResource.new(prods, options).serializable_hash
    end

    def get_groups
      groups = define_object.groups
      options = {group: :catalog}
      ActiveModelSerializers::SerializableResource.new(groups, options).serializable_hash
    end

    def sort_products(products)
      case @sort
        when 'price_asc' then products.order(min_price: :asc)
        when 'price_desc' then products.order(max_price: :desc)
        when 'lest' then products.order(updated_at: :desc)
      else
        products
      end
    end

    def klass
      case @type
        when :catalog
          @klass = WoodShop::Catalog
        when :category
          @klass = WoodShop::Category
      end
    end

    def slug
      case @type
        when :catalog
          @slug = @catalog_id
        when :category
          @slug = @category_id
      end
    end

    def filters_params
      return @filters_params if @filters_params
      @params[:filters].class == String ? @filters_params = ActiveSupport::JSON.decode(@params[:filters]) : @filters_params = @params[:filters]&.to_unsafe_hash
    end
  end
end