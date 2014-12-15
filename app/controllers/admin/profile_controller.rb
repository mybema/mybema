class Admin::ProfileController < AdminsController
  def edit
  end

  def update
    if current_admin.update_attributes(admin_params)
      sign_in(current_admin, bypass: true)
      flash[:notice] = 'Your profile has been updated.'
      redirect_to admin_path
    else
      render 'edit'
    end
  end

  private

  def admin_params
    admin_params_dup = params.require(:admin).permit(:name, :email, :password, :password_confirmation)

    if admin_params_dup[:password].blank? && admin_params_dup[:password_confirmation].blank?
      admin_params_dup.delete(:password)
      admin_params_dup.delete(:password_confirmation)
    end

    admin_params_dup
  end
end