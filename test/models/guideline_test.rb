# == Schema Information
#
# Table name: guidelines
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class GuidelineTest < ActiveSupport::TestCase
  test "raises validation warning if no name is added" do
    Guideline.new.invalid?(:name).must_equal true
  end

  test "guideline name must be unique" do
    create(:guideline, name: 'name')
    Guideline.new(name: 'name').invalid?(:name).must_equal true
  end
end
