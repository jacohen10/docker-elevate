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
    flash[:notice] = "#{@customer.name} your meal has been submitted. Waiting for #{@restaurant.name} to confirm!"
    redirect_to user_customer_path(current_user,@customer)
  end

  def edit

  end

  def update
    @restaurant = Restaurant.find(params[:restaurant_id])
    @meal = Meal.find(params[:meal_id])
    @meal.update(status: params[:status])
    redirect_to restaurant_path(@restaurant)
  end

  private
  def meal_params
    params.require(:meal).permit(:restaurant_id,:status,:food_item,:order_ahead,:comment)
  end
end
