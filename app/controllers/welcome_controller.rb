class WelcomeController < ApplicationController
  def index
    if current_user
      if current_user.role === "customer"
        @customer = current_user.customers[0]
      elsif current_user.role === "restaurant"
        @restaurant = current_user.restaurants[0]
      end
    end
  end

  def new_restaurant
  end
end
