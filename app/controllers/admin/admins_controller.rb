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
      redirect_to admins_path
    else
      flash[:alert] = 'Invitation could not be sent'
      render 'new'
    end
  end

  private

  def admin_params
    params.require(:admin).permit(:name, :email)
  end
end