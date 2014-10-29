class HomeController < ApplicationController
  def index
    @hero_message = HeroMessage.first
    @discussions  = Discussion.with_includes.visible.by_recency.limit(8)
  end
end