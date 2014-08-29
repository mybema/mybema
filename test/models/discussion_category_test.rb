# == Schema Information
#
# Table name: discussion_categories
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  slug              :string(255)
#  description       :text
#  discussions_count :integer          default(0)
#  created_at        :datetime
#  updated_at        :datetime
#

require 'test_helper'

class DiscussionCategoryTest < ActiveSupport::TestCase
  test "sluggifies the name during every save" do
    category = create(:discussion_category, name: "It's always sunny")
    assert_equal 'it-s-always-sunny', category.reload.slug
    category.update_attributes(name: "It's actually rainy now")
    assert_equal 'it-s-actually-rainy-now', category.reload.slug
  end

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

  test "nullifies foreign key for discussion when discussion category is deleted" do
    category = create(:discussion_category)
    discussion = create(:discussion, discussion_category: category)
    category.destroy
    assert_equal nil, discussion.reload.discussion_category_id
  end
end
