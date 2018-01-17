module WoodShop
  class SearchController < ApplicationController
    def index
      sp           = SearchProducts.new(params, cookies)
      @products    = sp.search
      @page        = sp.page
      @total_pages = sp.total_pages
      @path        = "#{search_index_path}?site_search=#{sp.search_query}"
    end
  end
end