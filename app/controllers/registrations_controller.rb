class RegistrationsController < Devise::RegistrationsController
  def new
    @ip_address = request.remote_ip
    super
  end

  private

  def sign_up_params
    params.require(:user).permit(:username, :email, :ip_address, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :current_password)
  end
end