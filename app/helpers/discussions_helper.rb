module DiscussionsHelper
  def subscription_button_for(discussion, current_user, current_admin)
    return nil if current_admin
    return nil if current_user.guest?

    if Subscription.where(discussion: discussion, user: current_user, subscribed: true).any?
      link_to unsubscribe_path(discussion.slug), method: :post, class: 'glyphicon-link-wrapper' do
        content_tag(:div, nil, class: 'hero-cta') do
          concat content_tag(:span, nil, class: 'icon-unsubscribe')
          concat content_tag(:span, 'unsubscribe', class: 'text-for-glyphicon')
        end
      end
    else
      link_to subscribe_path(discussion.slug), method: :post, class: 'glyphicon-link-wrapper' do
        content_tag(:div, nil, class: 'hero-cta') do
          concat content_tag(:span, nil, class: 'icon-subscribe')
          concat content_tag(:span, 'subscribe', class: 'text-for-glyphicon')
        end
      end
    end
  end
end