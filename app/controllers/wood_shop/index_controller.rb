module WoodShop
  class IndexController < ApplicationController

    # before_action :define_category, only: [ :show ]

    def index
      @title = 'Мужская и женская парфюмерия Днепропетровск. Интернет-магазин inflavor.com.uа. Бесплатная доставка туалетной и парфюмированной воды по Украине.'
      @description = 'Оригинальная мужская и женская парфюмерия в Днепропетровске. Доставка парфюмерии по всем городам Украины. Большой выбор, только оригинальная парфюмированная и туалетная вода, мужские и женские духи, одеколон.'
      @keywords = 'интернет, магазин, мужская, женская, купить, парфюмерия, Днепропетровск, бесплатная, доставка, по Украине, туалетная вода, парфюмированная вода'
      @rand = WoodShop::SubProduct.offset(rand(WoodShop::SubProduct.count)).limit(4)
    end

    def update
      @list.update(params_list) ? (render json: @list) : (render json: @list.errors, status: :unprocessable_entity)
    end

    def destroy
      @list.destroy ? (render json: @list) : (render json: @list.errors, status: :unprocessable_entity)
    end

    private

    def define_list
      @list = List.where(id: params[:id]).first
    end

    def params_list
      params.require(:list).permit(:name)
    end

  end
end