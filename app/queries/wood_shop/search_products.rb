module WoodShop
  class SearchProducts
    include WoodShop::Engine.routes.url_helpers

    attr_reader :params, :cookies, :options, :total_pages, :page, :search_query

    def initialize(params, cookies, **options)
      @params             = params
      @cookies            = cookies
      @search_query       = params[:site_search]
      @page               = params[:page] ? params[:page] : 1
      @total_pages        = 1
      @per                = cookies[:per] ? cookies[:per] : 12
      @options            = options
      @similarity_limit   = 0.228
      @min_priority_limit = 0.3
    end

    def search
      prods        = Kaminari.paginate_array(get_search_objects).page(@page).per(@per)
      @total_pages = prods.total_pages
      options      = {group: :catalog, pages: @total_pages}
      ActiveModelSerializers::SerializableResource.new(prods, options).serializable_hash
    end

    private

    def get_search_objects
      ActiveRecord::Base.connection.execute("select set_limit(#{@similarity_limit});")
      tmp_1 = WoodShop::Product.find_by_sql("select id, name, slug, min_price, max_price, small_text, sku_sub_products, similarity(name, '#{make_string}') as sm from wood_shop_products where id = #{make_string.to_i} or name % '#{make_string}' or sku_sub_products @> '{#{search_query.to_s}}'::character varying[] order by sm desc")
      tmp_2 = WoodShop::Product.find_by_sql("select id, name, slug, min_price, max_price, small_text, sku_sub_products from wood_shop_products where lower(name) like '%#{make_string}%'")
      insert_index = nil
      tmp_1.each_with_index { |object, index| insert_index ||= index if object.sm < @similarity_limit and object.id != make_string.to_i}
      insert_index ? tmp_1.insert(insert_index, tmp_2).flatten.uniq : (tmp_1 << tmp_2).flatten.uniq
    end

    def make_string
      search_query.to_s.uni_downcase.gsub(/'/){%q('')}
    end
  end
end