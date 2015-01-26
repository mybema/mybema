class SubscriptionsController < ApplicationController
  before_action :fetch_discussion

  def subscribe
    SubscriptionManagerService.new(@discussion, @current_user).subscribe
    flash[:notice] = 'You have been subscribed to this discussion'
    redirect_to discussion_path(@discussion.slug)
  end

  def unsubscribe
    SubscriptionManagerService.new(@discussion, @current_user).unsubscribe
    flash[:notice] = 'You have been unsubscribed from this discussion'
    redirect_to discussion_path(@discussion.slug)
  end

  private

  def fetch_discussion
    @discussion = Discussion.find_by_slug(params[:slug])
  end
end