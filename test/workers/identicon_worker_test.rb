require 'test_helper'
require 'sidekiq/testing'

Sidekiq::Testing.inline!

class IdenticonWorkerTest < ActiveSupport::TestCase
  def setup
    @user = create(:user)
  end

  test 'An instance of IdenticonCreator calls process' do
    discussion = create(:discussion, id: 992, user: @user)
    identicon_creator = MiniTest::Mock.new
    identicon_creator.expect :process, true
    IdenticonWorker.perform_async('Discussion', 992)
    identicon_creator.verify
  end
end