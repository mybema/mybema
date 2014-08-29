# == Schema Information
#
# Table name: discussion_comments
#
#  id            :integer          not null, primary key
#  body          :text
#  hidden        :boolean          default(FALSE)
#  discussion_id :integer
#  user_id       :integer
#  created_at    :datetime
#  updated_at    :datetime
#  admin_id      :integer
#

class DiscussionComment < ActiveRecord::Base
  belongs_to :discussion, counter_cache: true
  belongs_to :user
end