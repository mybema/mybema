require 'test_helper'
require 'sidekiq/testing'

Sidekiq::Testing.inline!

class ContentTransferWorkerTest < ActiveSupport::TestCase
  def setup
    create(:user, id: 701, username: 'Guest')
    create(:user, id: 702, username: 'Registered', )
  end

  test 'transfers a discussion from the guest user to the new user' do
    create(:discussion, guest_id: 'guest_id_value_from_cookie', user_id: 1)
    ContentTransferWorker.perform_async(702, 'guest_id_value_from_cookie')
    assert_equal Discussion.last.user_id, 702
    assert_equal Discussion.last.guest_id, nil
  end

  test 'transfers a discussion comment from the guest user to the new user' do
    create(:discussion_comment, guest_id: 'guest_id_value_from_cookie', user_id: 1)
    ContentTransferWorker.perform_async(702, 'guest_id_value_from_cookie')
    assert_equal DiscussionComment.last.user_id, 702
    assert_equal DiscussionComment.last.guest_id, nil
  end

  test 'transfers the guid from the cookie to the newly registered user' do
    create(:discussion_comment, guest_id: 'guest_id_value_from_cookie', user_id: 1)
    ContentTransferWorker.perform_async(702, 'guest_id_value_from_cookie')
    assert_equal User.find(702).guid, 'guest_id_value_from_cookie'
  end
end