class MealConfirmationsController < ApplicationController

  before_action :set_meal

  def call
    entree = @meal.restaurant.menus.find(@meal.food_item)
    side = Side.find(@meal.side)

    response = Twilio::TwiML::Response.new do |r|
      r.Say "This is Elevate alerting you of an advance order for take-out.", voice: 'woman'
      r.Say "An order was received for #{entree.name} and #{side.side_item}", voice: 'woman'
      r.Gather numDigits: '1', action: acknowledge_meal_confirmation_path(id: @meal.id), method: 'get' do |g|
        g.Say "Please press 1 to let us know you received the order", voice: 'woman'
      end
      r.Gather numDigits: '1', action: acknowledge_meal_confirmation_path(id: @meal.id), method: 'get' do |g|
        g.Say "We didn't receive any input. Please press 1 to let us know you received the order", voice: 'woman'
      end
      r.Say "We didn't receive any input. We will try calling again in a couple of minutes", voice: 'woman'
      r.Hangup
    end

    render text: response.text
  end

  def acknowledge
    pressed_number = params['Digits']

    response = Twilio::TwiML::Response.new do |r|
      if pressed_number == '1'
        Meals::Approver.call(@meal, 'cooking', false)
        r.Say "Thanks for confirming the order", voice: 'woman'
        r.Hangup
      else
        r.Gather numDigits: '1', action: acknowledge_meal_confirmation_path(id: @meal.id), method: 'get' do |g|
          g.Say "Please press 1 to let us know you received the order", voice: 'woman'
        end
        r.Redirect call_meal_confirmation_path
      end
    end

    render text: response.text
  end

  def complete
    Meals::Notifier.delay(run_at: 2.minutes.from_now).call(@meal, is_retry: true) unless @meal.is_cooking? || @meal.created_at < 10.minutes.ago

    render nothing: true
  end

  private

    def set_meal
      @meal = Meal.find(params[:id])
    end
end
