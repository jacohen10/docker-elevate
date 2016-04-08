require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  test 'should get index' do
    @user = FactoryGirl.create(:customer_user)
    sign_in @user

    get :index
    assert_response :success
  end
end
