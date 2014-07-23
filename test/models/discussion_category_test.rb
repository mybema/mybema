require 'test_helper'

class DiscussionCategoryTest < ActiveSupport::TestCase
  test "updates the discussion category counter cache with creation" do
    category   = create(:discussion_category)
    assert_equal 0, category.reload.discussions_count
    discussion = create(:discussion, discussion_category: category)
    assert_equal 1, category.reload.discussions_count
  end

  test "updates the discussion category counter cache with deletion" do
    category   = create(:discussion_category)
    discussion = create(:discussion, discussion_category: category)
    assert_equal 1, category.reload.discussions_count
    discussion.destroy
    assert_equal 0, category.reload.discussions_count
  end

  test "updates the discussion category counter when changing categories" do
    blue_category = create(:discussion_category)
    red_category  = create(:discussion_category)
    discussion    = create(:discussion, discussion_category: blue_category)

    assert_equal 1, blue_category.reload.discussions_count
    assert_equal 0, red_category.reload.discussions_count
    discussion.update_attributes discussion_category: red_category
    assert_equal 0, blue_category.reload.discussions_count
    assert_equal 1, red_category.reload.discussions_count
  end
end