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

  test 'displayable_hero' do
    displayable_hero.must_equal nil

    msg = create(:hero_message)
    displayable_hero(msg).must_equal true

    cookies['dismissed_hero'] = 'true'
    displayable_hero(msg).must_equal false
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

  test 'editable_discussion' do
    @peter = create(:user, username: 'Ferris')
    @sarah = create(:user, username: 'Sarah')

    # Guest with a different guid returns false
    def self.current_user; User.new(username: 'Guest'); end
    cookies['mybema_guest_id'] = 'one'
    discussion = create(:discussion, guest_id: 'two')
    editable_discussion(discussion).must_equal false

    # Guest with the same guid returns true
    def self.current_user; User.new(username: 'Guest'); end
    cookies['mybema_guest_id'] = 'same'
    discussion = create(:discussion, guest_id: 'same')
    editable_discussion(discussion).must_equal true

    # Signed in discussion owner returns true
    def self.current_user; @peter; end
    peter_discussion = create(:discussion, guest_id: 'non-existent', user: @peter)
    editable_discussion(peter_discussion).must_equal true

    # Signed in discussion non-owner returns false
    sarah_discussion = create(:discussion, guest_id: 'non-existent', user: @sarah)
    editable_discussion(sarah_discussion).must_equal false
  end
end