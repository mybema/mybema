require 'test_helper'

class AppController < ApplicationController
  def index
    render nothing: true
  end
end

class AppControllerTest < ActionController::TestCase
  def setup
    @guest_user = create(:user, username: 'Guest')
    @app = create(:app_settings)
  end

  def with_fake_routing
    with_routing do |map|
      map.draw do
        get '/example' => "app#index"
      end
      yield
    end
  end

  test "assigns the app settings" do
    with_fake_routing do
      get :index
      assert_equal @app, assigns(:app)
    end
  end

  test "assigns a user via fetch_user before action" do
    with_fake_routing do
      get :index
      assert_equal @guest_user, assigns(:current_user)
    end
  end

  test "assigns a new cookie for a new guest user" do
    with_fake_routing do
      get :index
      assert_not_nil cookies['mybema_guest_id']
    end
  end

  test "re-uses new cookie for a returning guest user" do
    with_fake_routing do
      @request.cookies['mybema_guest_id'] = 'old guid'
      get :index
      assert_equal "old guid", cookies['mybema_guest_id']
    end
  end

  test "does not assign cookie for a signed in user" do
    with_fake_routing do
      real_user = create(:user, username: 'realperson')
      sign_in(:user, real_user)
      get :index
      assert_nil cookies['mybema_guest_id']
    end
  end
end