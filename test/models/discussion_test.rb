# == Schema Information
#
# Table name: discussions
#
#  id                        :integer          not null, primary key
#  body                      :text
#  title                     :string(255)
#  hidden                    :boolean          default(FALSE)
#  discussion_category_id    :integer
#  user_id                   :integer
#  discussion_comments_count :integer          default(0)
#  created_at                :datetime
#  updated_at                :datetime
#  guest_id                  :string(255)
#  admin_id                  :integer
#  slug                      :string(255)
#

require 'test_helper'

class DiscussionTest < ActiveSupport::TestCase
  test "raises validation warning if no body is added" do
    build(:discussion, body: nil).invalid?(:discussion).must_equal true
  end

  test "raises validation warning if no title is added" do
    build(:discussion, title: nil).invalid?(:discussion).must_equal true
  end

  test "raises validation warning if no discussion_category_id is added" do
    build(:discussion, discussion_category_id: nil).invalid?(:discussion).must_equal true
  end

  test "raises validation warning if title is the same for the same user" do
    create(:discussion, user_id: 5, title: 'this is unique')
    build(:discussion, user_id: 5, title: 'this is unique').invalid?(:discussion).must_equal true
  end

  test "raises validation warning if title is the same for the same admin" do
    create(:discussion, user_id: nil, admin_id: 3, title: 'this too is unique')
    build(:discussion, user_id: nil, admin_id: 3, title: 'this too is unique').invalid?(:discussion).must_equal true
  end

  test "updates the discussion comments counter cache with comment creation" do
    discussion = create(:discussion)
    assert_equal 0, discussion.reload.discussion_comments_count
    comment = create(:discussion_comment, discussion: discussion)
    assert_equal 1, discussion.reload.discussion_comments_count
  end

  test "updates the discussion comments counter cache with comment deletion" do
    discussion = create(:discussion)
    comment = create(:discussion_comment, discussion: discussion)
    assert_equal 1, discussion.reload.discussion_comments_count
    comment.destroy
    assert_equal 0, discussion.reload.discussion_comments_count
  end

  test "deletes all comments when deleting a discussion" do
    discussion = create(:discussion)
    comment = create(:discussion_comment, discussion: discussion)
    comment = create(:discussion_comment, discussion: discussion)
    assert_equal 2, discussion.reload.discussion_comments_count
    discussion.destroy
    assert_equal 0, DiscussionComment.count
  end

  test "visible scope" do
    discussion_one = create(:discussion)
    discussion_two = create(:discussion)
    discussion_three = create(:discussion, hidden: true)
    assert_equal [discussion_one, discussion_two], Discussion.visible
  end

  test "recency scope" do
    discussion_one = create(:discussion)
    discussion_two = create(:discussion)
    discussion_three = create(:discussion, hidden: true)
    assert_equal [discussion_three, discussion_two, discussion_one], Discussion.by_recency

    discussion_two.update_attribute(:title, 'Updated')
    assert_equal [discussion_two, discussion_three, discussion_one], Discussion.by_recency
  end

  test '#username' do
    create(:user, id: 1, username: 'John')
    discussion = Discussion.new(user_id: 1)
    assert_equal 'John', discussion.username

    create(:admin, id: 100, name: 'CoolAdmin')
    discussion = Discussion.new(admin_id: 100)
    assert_equal 'CoolAdmin', discussion.username
  end

  test '#category_name' do
    category = create(:discussion_category, name: 'Categlory')
    discussion = create(:discussion, discussion_category: category)
    assert_equal discussion.category_name, 'Categlory'
  end

  test "sluggifies the title during every save" do
    discussion = create(:discussion, title: "Adventure Time")
    assert_equal 'adventure-time', discussion.reload.slug
    discussion.update_attributes(title: "Despicable me's an alright movie")
    assert_equal 'despicable-me-s-an-alright-movie', discussion.reload.slug
  end
end