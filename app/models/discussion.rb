# == Schema Information
#
# Table name: discussions
#
#  id                        :integer          not null, primary key
#  body                      :text
#  title                     :string(255)
#  hidden                    :boolean          default(FALSE)
#  discussion_category_id    :integer
#  user_id                   :integer
#  discussion_comments_count :integer          default(0)
#  created_at                :datetime
#  updated_at                :datetime
#

class Discussion < ActiveRecord::Base
  belongs_to :discussion_category, counter_cache: true
  belongs_to :user
  has_many :discussion_comments, dependent: :destroy

  validates :discussion_category_id, :body, :title, presence: true

  scope :by_recency, -> { order('created_at DESC') }
  scope :visible, -> { where(hidden: false) }
  scope :with_includes, -> { includes(:user).includes(:discussion_category) }

  def username
    if user_id?
      user.username
    else
      'Admin'
    end
  end
end