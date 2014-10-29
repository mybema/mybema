class Admin::SettingsController < AdminsController
  def index
    @hero_message = HeroMessage.first
  end
end