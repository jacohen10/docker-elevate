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
    if @meal.order_ahead === "order_ahead"
      UserMailer.order_ahead_email(User.find(@restaurant.user_id), @customer, @meal).deliver_now
      flash[:notice] = "#{@customer.name}, your meal has been submitted. Waiting for #{@restaurant.name} to confirm! Your meal should be ready for pickup at #{(@meal.created_at + 25.minutes).strftime("%I:%M%p")}"
    elsif @meal.order_ahead === "swipe"
      flash[:notice] = "#{@customer.name}, enjoy your #{@meal.food_item}! If dining in please remember to tip your waiter."
    end
    redirect_to user_customer_path(current_user,@customer)

  end

  def edit

  end

  def update
    session[:return_to] ||= request.referer
    @restaurant = Restaurant.find(params[:restaurant_id])
    @meal = Meal.find(params[:meal_id])
    @customer = Customer.find(@meal.customer_id)
    @user = User.find(@customer.user_id)
    @meal.update(status: params[:status], payment: params[:payment])
    if @meal.status === "cooking"
      UserMailer.order_ahead_customer(@user, @restaurant, @customer, @meal).deliver_now
    end
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
    Task.update_all(:id => params[:task_ids])
    redirect_to admin_restaurant_path(@restaurant)
  end

  private
  def meal_params
    params.require(:meal).permit(:restaurant_id,:status,:food_item,:order_ahead,:comment,:payment)
  end
end
