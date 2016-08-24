class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include CanCan::ControllerAdditions

  def after_sign_in_path_for(resource)
    if current_user.role == 'customer'
      user_customer_path(current_user, current_user.customers[0].id)
    elsif current_user.role == 'restaurant'
      user_restaurant_path(current_user, current_user.restaurants[0].id)
    elsif current_user.role == 'admin'
      user_restaurants_path(current_user)
    else
      super
    end
  end
end
