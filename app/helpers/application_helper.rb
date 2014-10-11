module ApplicationHelper
  def all_categories?(category=nil)
    return '' if category

    'active-category'
  end

  def active_category?(active=nil, selected=nil)
    return '' unless active && selected

    if active.name == selected.name
      'active-category'
    else
      ''
    end
  end

  def avatar_opts
    [cookies.permanent[:mybema_guest_id], @current_user.id]
  end

  def show_community_join_button?
    !current_admin && current_user.guest?
  end
end