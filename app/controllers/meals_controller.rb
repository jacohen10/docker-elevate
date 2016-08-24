class MealsController < ApplicationController
  before_action :set_customer, only: [:create, :destroy]
  before_action :set_restaurant, only: [:new, :update]

  def index
  end

  def show
  end

  def new
    @meal = @restaurant.meals.new
  end

  def create
    meal = Meals::Creator.call(meal_params, @customer)
    restaurant = meal.restaurant
    entree = restaurant.menus.find(meal.food_item)

    case meal.order_ahead
    when 'order_ahead'
      flash[:notice] = "#{@customer.first_name}, your meal has been submitted. Waiting for #{restaurant.name} to confirm! Your meal should be ready for pickup at #{(meal.created_at + 20.minutes).strftime('%I:%M%p')}. Please call #{restaurant.name} if you don’t receive an email confirmation within 10 minutes (check your ‘update’s’ folder in gmail)."
    when 'swipe'
      flash[:notice] = "#{@customer.first_name}, enjoy your #{entree.name}! If dining in please remember to tip your waiter."
    end

    redirect_to user_customer_path(current_user, @customer)
  end

  def edit
  end

  def update
    session[:return_to] ||= request.referer
    meal = Meal.find(params[:meal_id])
    Meals::Approver.call(meal, params[:status], params[:payment])
    redirect_to session.delete(:return_to)
  end

  def destroy
    @meal = Meal.find(params[:id])
    @meal.destroy
    flash[:notice] = 'Your meal has been cancelled successfully'
    redirect_to user_customer_path(current_user, @customer)
  end

  def complete
    Task.update_all(id: params[:task_ids])
    redirect_to admin_restaurant_path(@restaurant)
  end

  private

  def set_customer
    @customer = Customer.find(params[:customer_id])
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def meal_params
    params.require(:meal).permit(:restaurant_id, :status, :food_item, :order_ahead, :comment, :payment, :side)
  end
end
