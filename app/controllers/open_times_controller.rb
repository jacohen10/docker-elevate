class OpenTimesController < ApplicationController
  before_action :set_open_time, only: [:index,:show,:edit,:update,:destroy,:new,:create]
  load_and_authorize_resource


  def index
      @open_times = @restaurant.open_times.order(created_at: :asc)
  end

  def new
    @open_time = @restaurant.open_times.new
  end

  def create
    @restaurant.open_times.create(open_time_params)
    redirect_to restaurant_open_times_path(@restaurant)
  end

  def edit
    @open_time = @restaurant.open_times.find(params[:id])
  end

  def update
    @open_time = @restaurant.open_times.find(params[:id])
    @open_time.update(open_time_params)

    redirect_to restaurant_open_times_path(@restaurant)
  end

  def destroy
    @open_time = @restaurant.open_times.find(params[:id])
    @open_time.destroy
    redirect_to restaurant_open_times_path(@restaurant)
  end

  private
  def open_time_params
    params.require(:open_time).permit(:day,:opening,:closing)
  end

  def set_open_time
    if current_user.role === "admin"
      @restaurant = Restaurant.find(params[:restaurant_id])
    elsif current_user.role === "restaurant"
      @restaurant = current_user.restaurants.find(params[:restaurant_id])
    end
  end
end
