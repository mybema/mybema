require 'test_helper'

class UserTest < ActiveSupport::TestCase
  describe 'deleting users' do
    test "nullifies foreign key for discussion when user is deleted" do
      user = create(:user)
      discussion = create(:discussion, user: user)
      user.destroy
      assert_equal nil, discussion.reload.user_id
    end

    test "nullifies foreign key for discussion comment when user is deleted" do
      user = create(:user)
      comment = create(:discussion_comment, user: user)
      user.destroy
      assert_equal nil, comment.reload.user_id
    end
  end
end