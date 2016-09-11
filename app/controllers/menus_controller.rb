class MenusController < ApplicationController
  load_and_authorize_resource

  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @menus = @restaurant.menus
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @menus }
    end
  end

  def show
    @restaurant = Restaurant.find(params[:restaurant_id])
    @menu = @restaurant.menus.find(params[:id])
    render json: @menu
  end

  def new
    @category = Category.find(params[:category_id])
    @menu = @Category.menus.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @category = Category.find(params[:category_id])
    @category.menus.create(menu_params)
    redirect_to restaurant_categories_path(@restaurant)
  end

  def edit
    @restaurant = Restaurant.find(params[:restaurant_id])
    @category = Category.find(params[:category_id])
    @menu = @restaurant.menus.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:restaurant_id])
    @category = Category.find(params[:category_id])
    @menu = @restaurant.menus.find(params[:id])
    @menu.update(menu_params)

    redirect_to restaurant_categories_path(@restaurant)
  end

  def destroy
    @restaurant = Restaurant.find(params[:restaurant_id])
    @menu = @restaurant.menus.find(params[:id])
    @menu.destroy
    redirect_to restaurant_categories_path(@restaurant)
  end

  private

  def menu_params
    params.require(:menu).permit(:name, :meal_type, :details, :restaurant_id, :available)
  end
end
