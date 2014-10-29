class Admin::HeroMessagesController < AdminsController
  def update
    @hero_message = HeroMessage.first

    if @hero_message.update_attributes params.require(:hero_message).permit(:message)
      flash[:notice] = 'Hero message updated'
      redirect_to settings_path
    else
      flash[:alert] = 'Could not update hero message'
      redirect_to settings_path
    end
  end
end