class CustomersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_customer, only: [:show, :edit, :update]
  load_and_authorize_resource

  def index
    if current_user.role == 'admin'
      @customers = Customer.all
    else
      redirect_to '/'
    end
  end

  def show
    @restaurants = Restaurant.all.includes([:categories, { categories: :menus }, { categories: :sides }]).order(name: :asc)
    @meal = Meal.new
    @meals = @customer.meals.all.order(created_at: :desc).limit(10)
    @plan = @customer.plan
    @meals_remaining = (@customer.plan - @customer.meals.count)
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
    if current_user.role == 'admin'
      redirect_to customers_path

    elsif current_user.role == 'customer'
      redirect_to user_customer_path(current_user, @customer)
    else
      redirect_to '/'
    end
  end

  def edit
  end

  def update
    @customer.update(customer_params)
    if current_user.role == 'customer'
      redirect_to customer_path(@customer)
    else
      redirect_to customers_path
    end
  end

  def destroy
    if current_user.role == 'admin'
      @customer = Customer.find(params[:id])
      @customer.destroy
      redirect_to customers_path
    else
      redirect_to '/'
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :year, :phone, :email, :plan, :verification)
  end

  def set_customer
    if current_user.role == 'admin'
      @customer = Customer.find(params[:id])
    elsif current_user.role == 'customer'
      @customer = current_user.customers.find(params[:id])
    end
  end
end
