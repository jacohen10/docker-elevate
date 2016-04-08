FactoryGirl.define do
  factory :admin_user, class: User do
    email 'testing@email.com'
    password 'testing123'
    role 'admin'
  end

  factory :customer_user, class: User do
    email 'customer@email.com'
    password 'testing123'
    role 'customer'
  end

  factory :restaurant_user, class: User do
    email 'restaurant@email.com'
    password 'testing123'
    role 'restaurant'
  end
end
