require 'rails_helper'

describe Restaurant do
  before(:each) do
    @restaurant = Restaurant.create(name: "Mellow Mushroom", email: "testing@email.com", phone: 7578488208, order_ahead: true, in_restaurant_payment: true)
    expect(@restaurant).to be_a(Restaurant)
  end
  it "has Restaurant class" do

  end
  it "has business hours" do
    opentime = @restaurant.open_times.create(day:"Friday",opening: "12:00".to_time, closing: "20:00".to_time)
  end

end

describe Restaurant do
  before(:each) do
    @restaurant = Restaurant.create(name: "Mellow Mushroom", email: "testing@email.com", phone: 7578488208, order_ahead: true, in_restaurant_payment: true)
    expect(@restaurant).to be_a(Restaurant)
    @opentime = @restaurant.open_times.create(day:Time.now.strftime("%A"),opening: (Time.now - 5.hours), closing: (Time.now + 2.hours))
  end
  context "#has_business_hours" do
    it "has business hours" do
      expect(@restaurant.has_business_hours).to eql true
    end
  end

  context "#opening_time" do
    it "has opening time" do
      expect(@restaurant.opening_time(0).to_i).to be_a(Integer)
    end
  end

    context "#closing_time" do
      it "has closing time" do
        expect(@restaurant.closing_time(0).to_i).to be_a(Integer)
      end
    end

  describe "#is_open_one" do
    it "first set of business hours are open" do
      expect(@restaurant.is_open_one).to eql true
    end
  end

end
