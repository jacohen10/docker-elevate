class ChargesController < ApplicationController
  def new
  end

  def create
    @amount = params[:amountToCharge]
    @selectedPlan = params[:selectedPlan]
    @customer = current_user.customers.first
    @plan = @customer.plan + @selectedPlan.to_i

    charge(@amount, @selectedPlan)
    flash[:notice] = "#{@customer.first_name}, thank you for your business! If you ever have any questions or issues please don't hesitate to reach us at hello@elevatemealplan.com"
    redirect_to user_customer_path(current_user, current_user.customers[0].id)
  end

  private

  def charge(amountToCharge, selectedPlan)
    @customer = current_user.customers.first
    charge_error = nil
    begin
      customer = Stripe::Customer.create(
        email:  current_user.email,
        source:  params[:stripeToken]
      )

      charge = Stripe::Charge.create(
        customer:     customer.id,
        amount:       amountToCharge,
        description:  "Elevate Meal #{ selectedPlan} Plan",
        currency:     'usd',
        metadata:     {meal: selectedPlan}
      )

    rescue Stripe::CardError => e
     charge_error = e.message
    end
    if charge_error
     flash[:error] = charge_error
    else
      @customer.update(plan: @plan)
      UserMailer.plan_renewal(current_user, selectedPlan, amountToCharge).deliver_now
    end

  end

end
