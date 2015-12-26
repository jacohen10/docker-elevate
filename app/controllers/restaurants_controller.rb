class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show,:edit,:update,:destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  load_and_authorize_resource

  def status_close
    @meal = Meal.find(params[:meal_id])
    @meal.status = "closed"
    redirect_to restaurant_path(@restaurant)
  end

  def index
    if current_user.role == "admin"
      @restaurants = Restaurant.all
    # elsif current_user.role == "customer"
    #   @restaurant = current_user.restaurants.create(restaurant_params)
    end



  end

  def show
    if current_user
      @customers = Customer.all
      @meal = Meal.new
      @meals = @restaurant.meals.all.order(created_at: :asc)
      @menus = @restaurant.menus.all
    end
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = current_user.restaurants.create(restaurant_params)
    redirect_to user_restaurant_path(current_user, @restaurant)
  end

  def edit
  end

  def update
    @restaurant.update(restaurant_params)
    redirect_to restaurant_path(@restaurant)
  end

  def destroy
    @restaurant.destroy
    redirect_to restaurants_path
  end

  private
  def restaurant_params
    params.require(:restaurant).permit(:name,:contact,:email,:phone,:menu)
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

end
