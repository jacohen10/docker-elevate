module Meals
  class Notifier
    def self.call(*args)
      new(*args).call
    end

    def initialize(meal, is_retry = false)
      @meal = meal
      @is_retry = is_retry
    end

    def call
      restaurant = meal.restaurant
      customer = meal.customer

      # Send email
      unless is_retry
        entree = restaurant.menus.find(meal.food_item)
        side = Side.find(meal.side) # perhaps we should have an association between Meal and Side?
        UserMailer.order_ahead_email(restaurant.user, customer, meal, entree, side).deliver_now
      end

      # Call restaurant about the new order
      restaurant_number = restaurant.phone
      initiate_call(restaurant_number)
    end
    handle_asynchronously :call

    private

    attr_reader :meal, :is_retry

    def initiate_call(restaurant_number)
      twilio_client = Twilio::REST::Client.new

      twilio_client.account.calls.create(
        from: "+1#{Rails.application.secrets.twilio_phone_number}",
        to: restaurant_number,
        url: Rails.application.routes.url_helpers.call_meal_confirmation_url(id: @meal.id, format: :xml),
        method: 'GET',
        status_callback: Rails.application.routes.url_helpers.complete_meal_confirmation_url(id: @meal.id, format: :xml),
        status_callback_method: 'GET')
    end
  end
end
