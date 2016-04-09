module Meals
  class Approver
    def self.call(*args)
      new(*args).call
    end

    def initialize(meal, status, payment)
      @meal = meal
      @status = status
      @payment = payment
    end

    def call
      customer = meal.customer
      user = customer.user
      restaurant = meal.restaurant
      entree = restaurant.menus.find(meal.food_item)

      if meal.update(status: status, payment: payment) && meal.is_cooking?
        UserMailer.order_ahead_customer(user, restaurant, customer, entree).deliver_now
      end
    end

    private

    attr_reader :meal, :status, :payment
  end
end
