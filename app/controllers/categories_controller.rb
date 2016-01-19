class CategoriesController < ApplicationController
  load_and_authorize_resource


  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @categories = @restaurant.categories
    @menu = Menu.new
  end

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @category = @restaurant.categories.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @restaurant.categories.create(category_params)
    redirect_to restaurant_categories_path(@restaurant)
  end

  def edit
    @restaurant = Restaurant.find(params[:restaurant_id])
    @category = @restaurant.categories.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:restaurant_id])
    @category = @restaurant.categories.find(params[:id])
    @category.update(category_params)

    redirect_to restaurant_categories_path(@restaurant)
  end

  def destroy
    @restaurant = Restaurant.find(params[:restaurant_id])
    @category = @restaurant.categories.find(params[:id])
    @category.destroy
    redirect_to restaurant_categories_path(@restaurant)
  end

  private
  def category_params
    params.require(:category).permit(:name, :comment)
  end
end
