class WelcomeController < ApplicationController
  def index
    if current_user
      @customer = current_user.customers[0]
    end
  end

  def new_restaurant
  end
end
