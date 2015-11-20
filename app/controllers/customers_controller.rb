class CustomersController < ApplicationController
  before_action :set_customer, only: [:show,:edit,:update,:destroy]
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
    @customer = Customer.new
  end

  def create
    @customer = current_user.customers.create(customer_params)

    if current_user.role == "admin"
      redirect_to customers_path
    elsif current_user.role == "customer"
      redirect_to user_customer_path(current_user, @customer)
    end
  end

  def edit
  end

  def update
    @customer.update(customer_params)
    redirect_to customer_path(@customer)
  end

  def destroy
    @customer.destroy
    redirect_to customers_path
  end



  private
  def customer_params
    params.require(:customer).permit(:name,:year,:email,:plan)
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end

end
