class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
     new_user_customer_path(current_user)# Or :prefix_to_your_route
  end


  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end

end
