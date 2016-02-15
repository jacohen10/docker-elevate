class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:admin,:show,:edit,:update,:destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
    if current_user.role == "admin"
      @restaurants = Restaurant.all
      @meals = Meal.all.count
    end
  end

  def admin
    # (Time.now.beginning_of_month + 14.day).strftime("%m/%d/%y")
    # ((Time.now.beginning_of_month + 15.day)..Time.now.end_of_month).days

    @meals_current_month =  @restaurant.meals.where(created_at: Time.now.beginning_of_month..Time.now.end_of_month, payment: true).count
    @first_half_current_month =  @restaurant.meals.where(created_at: Time.now.beginning_of_month..(Time.now.beginning_of_month + 14.day), payment: true).count
    @second_half_current_month = @restaurant.meals.where(created_at: (Time.now.beginning_of_month + 15.day)..Time.now.end_of_month, payment: true).count
    @meals_previous_month =  @restaurant.meals.where(created_at: (1.month.ago.beginning_of_month)..(1.month.ago.end_of_month), payment: true).count
    @first_half_previous_month =  @restaurant.meals.where(created_at: (1.month.ago.beginning_of_month)..(1.month.ago.beginning_of_month + 14.day), payment: true).count
    @second_half_previous_month =  @restaurant.meals.where(created_at: (1.month.ago.beginning_of_month + 15.day)..(1.month.ago.end_of_month), payment: true).count
    @unpaid_meals = @restaurant.meals.where(status: "closed", payment: false).order(created_at: :desc)
    @paid_meals = @restaurant.meals.where(status: "closed", payment: true).count
    @meals = @restaurant.meals.all.order(created_at: :desc)
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
  end

  def update
    session[:return_to] ||= request.referer
    @unpaid_meals = @restaurant.meals.where(status: "closed", payment: false)

    @restaurant.update(restaurant_params)
    redirect_to session.delete(:return_to)
  end

  def destroy
    @restaurant.destroy
    redirect_to restaurants_path
  end

  private
  def restaurant_params
    params.require(:restaurant).permit(:name,:contact,:email,:phone,:menu,:order_ahead,:in_restaurant_payment, meals_attributes: [:id,:payment])
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

end
