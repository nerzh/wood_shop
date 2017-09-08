module WoodShop
  class IndexController < ApplicationController

    def index
      @title       = 'Детские игрушки, квадрокоптеры, радиоуправляемые модели, вертолеты, машинки на радиоуправлении, подводные лодки - saletoys.com.ua'
      @description = 'Детские игрушки, квадрокоптеры, радиоуправляемые модели, вертолеты, машинки на радиоуправлении, подводные лодки - saletoys.com.ua'
      @keywords    = 'Детские игрушки, квадрокоптеры, радиоуправляемые модели, вертолеты, машинки на радиоуправлении, подводные лодки - saletoys.com.ua'
      @rand        = WoodShop::Product.offset(rand(WoodShop::Product.count)).limit(4)

      @catalogs    = WoodShop::Catalog.includes(:categories).select('wood_shop_catalogs.id',
                                                                    'wood_shop_catalogs.name',
                                                                    'wood_shop_catalogs.slug')
    end

  end
end