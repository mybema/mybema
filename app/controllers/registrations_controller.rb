class RegistrationsController < Devise::RegistrationsController
  def new
    @ip_address = request.remote_ip
    super
  end

  def create
    build_resource(sign_up_params)

    resource_saved = resource.save
    yield resource if block_given?
    if resource_saved
      transfer_guest_content resource
      remove_guest_cookie

      MybemaDeviseMailer.send_welcome(resource).deliver unless resource.invalid?

      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      @validatable = devise_mapping.validatable?
      if @validatable
        @minimum_password_length = resource_class.password_length.min
      end
      respond_with resource
    end
  end

  private

  def account_update_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :current_password)
  end

  def remove_guest_cookie
    cookies.delete :mybema_guest_id
  end

  def sign_up_params
    params.require(:user).permit(:username, :email, :ip_address, :password, :password_confirmation)
  end

  def transfer_guest_content resource
    if guest_id = cookies[:mybema_guest_id]
      ContentTransferWorker.perform_async resource.id, guest_id
    end
  end
end