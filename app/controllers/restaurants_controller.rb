class RestaurantsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_restaurant, only: [:admin, :show, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
    if current_user.role == 'admin'
      @restaurants = Restaurant.all.order(created_at: :asc)
      @meals = Meal.all
      @today = (Time.zone.now).beginning_of_day
      @yesterday = (Time.zone.now - 1.day).beginning_of_day
    end
  end

  def admin
    @meals_current_month = @restaurant.meals.where(created_at: Time.now.beginning_of_month..Time.now.end_of_month, payment: true).count
    @first_half_current_month =  @restaurant.meals.where(created_at: Time.now.beginning_of_month..(Time.now.beginning_of_month + 14.days), payment: true).count
    @second_half_current_month = @restaurant.meals.where(created_at: (Time.now.beginning_of_month + 15.days)..Time.now.end_of_month, payment: true).count
    @meals_previous_month = @restaurant.meals.where(created_at: (1.month.ago.beginning_of_month)..(1.month.ago.end_of_month), payment: true).count
    @first_half_previous_month = @restaurant.meals.where(created_at: (1.month.ago.beginning_of_month)..(1.month.ago.beginning_of_month + 14.days), payment: true).count
    @second_half_previous_month = @restaurant.meals.where(created_at: (1.month.ago.beginning_of_month + 15.days)..(1.month.ago.end_of_month), payment: true).count
    @unpaid_meals = @restaurant.meals.includes(:customer, :restaurant).where(status: 'closed', payment: false).order(created_at: :desc)
    @paid_meals = @restaurant.meals.where(status: 'closed', payment: true).order(created_at: :desc)
    # @meals = @restaurant.meals.all.order(created_at: :desc)
    @unpaid_meal_count = @unpaid_meals.count
    @amount_owed = (@unpaid_meal_count * 8.70)
    @today = (Time.zone.now).beginning_of_day
    @yesterday = (Time.zone.now - 1.day).beginning_of_day
  end

  def show
    if current_user
      @customers = Customer.all
      @meal = Meal.new
      @meals = @restaurant.meals.includes([:customer, :restaurant]).all.order(created_at: :asc)
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
    @unpaid_meals = @restaurant.meals.where(status: 'closed', payment: false)

    @restaurant.update(restaurant_params)
    redirect_to session.delete(:return_to)
  end

  def destroy
    @restaurant.destroy
    redirect_to restaurants_path
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :contact, :email, :phone, :menu, :order_ahead, :cook_time, :in_restaurant_payment, meals_attributes: [:id, :payment])
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
end
