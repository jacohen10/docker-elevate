FactoryGirl.define do
  factory :test_customer, class: Customer do
    first_name 'perfect'
    last_name 'customer'
    email 'customer@testing.com'
    plan 45
  end
end
