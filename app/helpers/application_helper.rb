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

  def displayable_hero(msg=nil)
    msg && cookies[:dismissed_hero] != 'true'
  end

  def editable_discussion discussion
    (current_user.logged_in? && discussion.user == current_user) ||
    (discussion.guest_id == cookies.permanent[:mybema_guest_id])
  end

  def show_community_join_button?
    !current_admin && current_user.guest?
  end
end