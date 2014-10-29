require 'test_helper'

class Admin::HeroMessagesControllerTest < ActionController::TestCase
  def setup
    @hero_message = create(:hero_message, id: 1)
    create(:user, username: 'Guest')
    admin = create(:admin)
    sign_in(:admin, admin)
  end

  test "PUT update assigns the hero message" do
    put :update, id: 1, hero_message: { message: 'something new' }
    assert_equal @hero_message, assigns(:hero_message)
  end

  test "PUT update redirects to settings_path" do
    put :update, id: 1, hero_message: { message: 'something new' }
    assert_redirected_to settings_path
  end

  test "PUT update changes the hero message" do
    put :update, id: 1, hero_message: { message: 'something new' }
    assert_equal HeroMessage.last.message, 'something new'
  end
end