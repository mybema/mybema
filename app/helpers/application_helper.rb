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
end