# == Schema Information
#
# Table name: sections
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  articles_count :integer          default(0)
#  created_at     :datetime
#  updated_at     :datetime
#

require 'test_helper'

class SectionTest < ActiveSupport::TestCase
  test "nullifies article's foreign key when destroyed" do
    section = create(:section)
    article = create(:article, section: section)
    section.destroy
    assert_equal nil, article.reload.section_id
  end

  test 'with_articles scope' do
    section1 = create(:section)
    section2 = create(:section)
    article1 = create(:article, section: section1)
    assert_equal [section1], Section.with_articles
  end

  test "raises validation warning if no title is added" do
    build(:section, title: nil).invalid?(:title).must_equal true
  end

  test "raises validation warning if title is already taken" do
    create(:section, title: 'one')
    build(:section, title: 'one').invalid?(:title).must_equal true
  end
end