class Admin::AppSettingsController < AdminsController
  def index
  end

  def update
    if @app.update_attributes(app_settings_params)
      flash[:notice] = 'App settings have been updated'
      redirect_to app_settings_path
    else
      flash[:alert] = 'Could not update changes'
      redirect_to app_settings_path
    end
  end

  private

  def app_settings_params
    params.require(:app_settings).permit!
  end
end