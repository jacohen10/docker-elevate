class SidesController < ApplicationController
  load_and_authorize_resource


  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @sides = @restaurant.sides
  end

  def new
    @category = Category.find(params[:category_id])
    @side = @Category.sides.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @category = Category.find(params[:category_id])
    @category.sides.create(side_params)
    redirect_to restaurant_categories_path(@restaurant)
  end

  def edit
    @restaurant = Restaurant.find(params[:restaurant_id])
    @category = Category.find(params[:category_id])
    @side = @restaurant.sides.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:restaurant_id])
    @category = Category.find(params[:category_id])
    @side = @restaurant.sides.find(params[:id])
    @side.update(side_params)

    redirect_to restaurant_categories_path(@restaurant)
  end

  def destroy
    @restaurant = Restaurant.find(params[:restaurant_id])
    @side = @restaurant.sides.find(params[:id])
    @side.destroy
    redirect_to restaurant_categories_path(@restaurant)
  end

  private
  def side_params
    params.require(:side).permit(:side_item,:details, :category_id)
  end
end
