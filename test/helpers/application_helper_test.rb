require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test 'all_categories?' do
    all_categories?().must_equal 'active-category'
    all_categories?('cool category').must_equal ''
  end


  test 'active_category?' do
    TestCategory = Struct.new(:name)
    same = TestCategory.new('same')
    different = TestCategory.new('different')

    active_category?().must_equal ''
    active_category?(same).must_equal ''
    active_category?(same, different).must_equal ''
    active_category?(same, same).must_equal 'active-category'
  end

  test 'show_community_join_button?' do
    def self.current_admin; false; end
    def self.current_user; User.new(username: 'Guest'); end
    show_community_join_button?.must_equal true

    def self.current_admin; false; end
    def self.current_user; User.new(username: 'Bob'); end
    show_community_join_button?.must_equal false

    def self.current_admin; Admin.new; end
    def self.current_user; User.new(username: 'Guest'); end
    show_community_join_button?.must_equal false
  end
end