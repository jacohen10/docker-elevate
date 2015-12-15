class CustomersController < ApplicationController
  before_action :set_customer, only: [:show,:edit,:update]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
    @customers = Customer.all
  end

  def show
    @restaurants = Restaurant.all
    @meal = Meal.new
    @meals = @customer.meals.all.order(created_at: :desc)
    @plan = @customer.plan
    @meals_remaining = ((@customer.plan)-@customer.meals.where(status: "closed").count)
  end

  def new
    if current_user.customers.count < 1
      @customer = Customer.new
    else
      redirect_to '/'
    end
  end

  def create
    @customer = current_user.customers.create(customer_params)
    if current_user.role == "admin"
      redirect_to customers_path

    elsif current_user.role == "customer"
      redirect_to user_customer_path(current_user, @customer)
    else
      redirect_to '/'
    end
  end

  def edit
  end

  def update
      @customer.update(customer_params)
      redirect_to customer_path(@customer)
  end

  def destroy
    if current_user.role == "admin"
      @customer = Customer.find(params[:id])
      @customer.destroy
      redirect_to customers_path
    else
      redirect_to '/'
    end

  end



  private
  def customer_params
    params.require(:customer).permit(:name,:year,:email,:plan)
  end

  def set_customer
    if current_user.role == "admin"
      @customer = Customer.find(params[:id])
    elsif current_user.role == "customer"
      @customer = current_user.customers.find(params[:id])
    end
  end

end
