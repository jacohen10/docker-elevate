class MealsController < ApplicationController


  def index
  end

  def show
  end

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @meal = @restaurant.meals.new
  end

  def create
    @customer = Customer.find(params[:customer_id])
    @meal = @customer.meals.create(meal_params)
    @restaurant = Restaurant.find(@meal.restaurant_id)
    flash[:notice] = "#{@customer.name} your meal has been submitted. Waiting for #{@restaurant.name} to confirm! Your meal should be ready for pickup at #{(@meal.created_at + 25.minutes).strftime("%I:%M%p")}"
    redirect_to user_customer_path(current_user,@customer)
  end

  def edit

  end

  def update
    session[:return_to] ||= request.referer
    @restaurant = Restaurant.find(params[:restaurant_id])
    @meal = Meal.find(params[:meal_id])
    @meal.update(status: params[:status], payment: params[:payment])
    redirect_to session.delete(:return_to)
  end

  def destroy
    @customer = Customer.find(params[:customer_id])
    @meal = Meal.find(params[:id])
    @meal.destroy
    flash[:notice] = "Your meal has been cancelled successfully"
    redirect_to user_customer_path(current_user, @customer)
  end

  def complete
    session[:return_to] ||= request.referer
    # TODO mark selected meals as Paid
    redirect_to session.delete(:return_to)
  end

  private
  def meal_params
    params.require(:meal).permit(:restaurant_id,:status,:food_item,:order_ahead,:comment,:payment)
  end
end
