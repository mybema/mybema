class Admin::AdminsController < AdminsController
  def index
    @admins = Admin.all
  end

  def new
    @admin = Admin.new
  end

  def create
    if Admin.invite!(email: admin_params[:email], name: admin_params[:name])
      flash[:notice] = 'Your invitation was sent'
      redirect_to administrators_path
    else
      flash[:alert] = 'Invitation could not be sent'
      render 'new'
    end
  end

  def destroy
    @admin = Admin.find(params[:id])

    if current_admin.can_destroy(@admin) && @admin.destroy
      redirect_to administrators_path
    else
      flash[:alert] = 'You cannot delete yourself'
      redirect_to administrators_path
    end
  end

  private

  def admin_params
    params.require(:admin).permit(:name, :email)
  end
end