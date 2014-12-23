# == Schema Information
#
# Table name: app_settings
#
#  id                  :integer          not null, primary key
#  all_articles_img    :string(255)
#  all_discussions_img :string(255)
#  join_community_img  :string(255)
#  new_discussion_img  :string(255)
#  logo                :string(255)
#  hero_message        :text
#  created_at          :datetime
#  updated_at          :datetime
#  seed_level          :integer          default(0)
#  guest_posting       :boolean          default(TRUE)
#

require 'test_helper'

class AppSettingsTest < ActiveSupport::TestCase
  def setup
    @test_file = File.open(Rails.root.join('test', 'fixtures', 'image.png'))
    @app = create(:app_settings)
  end

  test "raises validation warning if no hero_message is added" do
    AppSettings.new.invalid?(:hero_message).must_equal true
  end

  test '#all_articles_image' do
    assert_equal @app.all_articles_image, 'folder.png'

    @app.update(all_articles_img: @test_file)
    assert_equal @app.reload.all_articles_image, '/uploads/app_settings/image.png'
  end

  test '#all_discussions_image' do
    assert_equal @app.all_discussions_image, 'bulb.png'

    @app.update(all_discussions_img: @test_file)
    assert_equal @app.reload.all_discussions_image, '/uploads/app_settings/image.png'
  end

  test '#join_community_image' do
    assert_equal @app.join_community_image, 'heart.png'

    @app.update(join_community_img: @test_file)
    assert_equal @app.reload.join_community_image, '/uploads/app_settings/image.png'
  end

  test '#new_discussion_image' do
    assert_equal @app.new_discussion_image, 'mic.png'

    @app.update(new_discussion_img: @test_file)
    assert_equal @app.reload.new_discussion_image, '/uploads/app_settings/image.png'
  end

  test '#logo_image' do
    assert_equal @app.logo_image, 'new-logo.png'

    @app.update(logo: @test_file)
    assert_equal @app.reload.logo_image, '/uploads/app_settings/image.png'
  end
end
