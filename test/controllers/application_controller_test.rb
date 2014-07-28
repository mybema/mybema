require 'test_helper'

class AppController < ApplicationController
  def index
    render nothing: true
  end
end

class AppControllerTest < ActionController::TestCase
  def setup
    @guest_user = create(:user, username: 'Guest')
  end

  def with_fake_routing
    with_routing do |map|
      map.draw do
        get '/example' => "app#index"
      end
      yield
    end
  end

  test "assigns a user via fetch_user before action" do
    with_fake_routing do
      create(:discussion, user: @guest_user)
      get :index
      assert_equal @guest_user, assigns(:current_user)
    end
  end
end