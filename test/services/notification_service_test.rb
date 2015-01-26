require 'test_helper'

class NotificationServiceTest < ActiveSupport::TestCase
  before :each do
    @user  = create(:user)
    @admin = create(:admin)
    create(:app_settings)
  end

  test '#deliver_notifications notifies subscribers if there are any' do
    discussion = create(:discussion)
    user_two   = create(:user)
    opts       = { discussion: discussion, user: @user, admin: @admin }

    discussion.subscriptions.create(user: user_two)
    service = NotificationService.new(opts)
    refute_equal service.deliver_notifications, nil
  end

  test '#deliver_notifications notifies nobody if there are no subscribers' do
    discussion = create(:discussion)
    opts       = { discussion: discussion, user: @user, admin: @admin }

    service = NotificationService.new(opts)
    assert_equal service.deliver_notifications, nil
  end

  test '#notify_admins returns nil if an admin is passed in the arguments' do
    comment = create(:discussion_comment)
    opts    = { comment: comment, user: @user, admin: @admin }

    service = NotificationService.new(opts)
    assert_equal service.notify_admins, nil
  end

  test '#notify_admins delivers a notification if no admin is passed in the arguments' do
    comment = create(:discussion_comment)
    opts    = { comment: comment, user: @user }

    service = NotificationService.new(opts)
    assert_equal service.notify_admins, true
  end

  test '#notify_admins_of_new_discussion returns nil if an admin is passed in the arguments' do
    comment = create(:discussion_comment)
    opts    = { comment: comment, user: @user, admin: @admin }

    service = NotificationService.new(opts)
    assert_equal service.notify_admins_of_new_discussion, nil
  end

  test '#notify_admins_of_new_discussion delivers a notification if no admin is passed in the arguments' do
    comment = create(:discussion_comment)
    opts    = { comment: comment, user: @user }

    service = NotificationService.new(opts)
    assert_equal service.notify_admins_of_new_discussion, true
  end
end