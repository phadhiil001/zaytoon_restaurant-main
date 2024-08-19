class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    @products = Product.all

    @products = @products.page(params[:page]).per(20)
  end

  def show
    @category = Category.find(params[:id])
    @products = @category.products.page(params[:page]).per(10)
  end
end
