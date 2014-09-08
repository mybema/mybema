require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test 'all_categories?' do
    all_categories?().must_equal 'active-category'
    all_categories?('cool category').must_equal ''
  end

  TestCategory = Struct.new(:name)

  test 'active_category?' do
    same = TestCategory.new('same')
    different = TestCategory.new('different')

    active_category?().must_equal ''
    active_category?(same).must_equal ''
    active_category?(same, different).must_equal ''
    active_category?(same, same).must_equal 'active-category'
  end
end