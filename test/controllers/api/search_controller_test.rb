require 'test_helper'

class Api::SearchControllerTest < ActionController::TestCase
  def setup
    create(:user, username: 'Guest')
  end

  test "GET typeahead_article_prefetch responds successfully" do
    get :typeahead_article_prefetch
    assert_response :success, @response.body
  end

  test "GET typeahead_discussion_prefetch responds successfully" do
    get :typeahead_discussion_prefetch
    assert_response :success, @response.body
  end

  test "GET typeahead_article_prefetch returns a json response" do
    create(:article, body: 'body', title: 'title', id: 1)
    get :typeahead_article_prefetch
    assert_equal [{"id"=>1,"title"=>"title","body"=>"body","class_name"=>"article"}], JSON.parse(@response.body)
  end

  test "GET typeahead_discussion_prefetch returns a json response" do
    create(:discussion, body: 'body', title: 'title', id: 1)
    get :typeahead_discussion_prefetch
    assert_equal [{"id"=>1,"title"=>"title","slug"=>"title","body"=>"body","class_name"=>"discussion"}], JSON.parse(@response.body)
  end
end