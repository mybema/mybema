module UserDetails
  extend ActiveSupport::Concern

  def user_avatar cookie_guid_value, content_user_id
    if user_id? && (user_id == content_user_id) # Guest
      user.avatar_url cookie_guid_value
    elsif user_id? # Registered user
      user.avatar_url
    else
      "admin.png"
    end
  end
end