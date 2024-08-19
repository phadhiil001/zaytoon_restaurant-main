class HomeController < ApplicationController
  def index
    @categories = Category.all
    @products = Product.all

    if params[:search].present?
      @products = @products.where('products.name LIKE ? OR products.description LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%")
    end

    if params[:category].present?
      @products = @products.joins(:category).where(categories: { id: params[:category] })
    end

    if params[:filter].present?
      case params[:filter]
      when 'on_sale'
        @products = @products.on_sale
      when 'new'
        @products = @products.new_products
      when 'recently_updated'
        @products = @products.recently_updated
      end
    end

    @products = @products.page(params[:page]).per(12)
  end
end
