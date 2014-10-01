# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  body       :text
#  title      :string(255)
#  section_id :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test "raises validation warning if duplicate title for the same section" do
    section = create(:section)
    create(:article, section: section, title: 'title')
    build(:article, title: 'title', section: section).invalid?(:title).must_equal true
  end

  test "doesn't raise validation warning if duplicate title for a different section" do
    section = create(:section)
    section_two = create(:section)
    create(:article, section: section, title: 'another title')
    build(:article, title: 'another title', section: section_two).invalid?(:title).must_equal false
  end

  test "raises validation warning if no body is added" do
    build(:article, body: nil).invalid?(:article).must_equal true
  end

  test "raises validation warning if no title is added" do
    build(:article, title: nil).invalid?(:article).must_equal true
  end
end
