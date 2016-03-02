module Meals
  class Creator

    def self.call(*args)
      new(*args).call
    end

    def initialize(meal_params, customer)
      @meal_params = meal_params
      @customer = customer
    end

    def call
      meal = customer.meals.build(meal_params)
      Meals::Notifier.call(meal) if meal.save && meal.order_ahead == 'order_ahead'
      meal
    end

    private

      attr_reader :meal_params, :customer

  end
end
