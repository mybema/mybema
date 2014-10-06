class AdminsController < ApplicationController
  before_action :authenticate_admin!
  skip_before_action :fetch_user_and_handle_guest_cookie
  layout 'admin'
end