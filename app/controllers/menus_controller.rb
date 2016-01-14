class MenusController < ApplicationController
  load_and_authorize_resource


  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @menus = @restaurant.menus
  end

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @menu = @restaurant.menus.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @restaurant.menus.create(menu_params)
    redirect_to restaurant_menus_path(@restaurant)
  end

  def edit
    @restaurant = Restaurant.find(params[:restaurant_id])
    @menu = @restaurant.menus.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:restaurant_id])
    @menu = @restaurant.menus.find(params[:id])
    @menu.update(menu_params)

    redirect_to restaurant_menus_path(@restaurant)
  end

  def destroy
    @restaurant = Restaurant.find(params[:restaurant_id])
    @menu = @restaurant.menus.find(params[:id])
    @menu.destroy
    redirect_to restaurant_menus_path(@restaurant)
  end

  private
  def menu_params
    params.require(:menu).permit(:name,:meal_type,:details)
  end
end
