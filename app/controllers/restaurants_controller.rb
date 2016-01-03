class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:admin,:show,:edit,:update,:destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
    if current_user.role == "admin"
      @restaurants = Restaurant.all
    end
  end

  def admin
    @unpaid_meals = @restaurant.meals.where(status: "closed", payment: false)
    @meals = @restaurant.meals.all.order(created_at: :asc)
    @unpaid_meal_count = @unpaid_meals.count
    @amount_owed = (@unpaid_meal_count * 8.70)
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
    @unpaid_meals = @restaurant.meals.where(status: "closed", payment: false)

    @unpaid_meals.update_all({payment: true}, )
  end

  def update
    @unpaid_meals = @restaurant.meals.where(status: "closed", payment: false)

    respond_to do |format|
      if @restaurant.update(restaurant_params)
      format.html {redirect_to restaurant_path(@restaurant)}
      else
        format.html {render action: "edit"}
      end
    end
  end

  def destroy
    @restaurant.destroy
    redirect_to restaurants_path
  end

  private
  def restaurant_params
    params.require(:restaurant).permit(:name,:contact,:email,:phone,:menu, meals_attributes: [:id,:payment])
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

end
