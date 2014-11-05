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
#  guest_id                  :string(255)
#

class Discussion < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include UserDetails
  include Humanizer

  index_name "discussion_#{Rails.env}"

  belongs_to :discussion_category, counter_cache: true
  belongs_to :user
  has_many :discussion_comments, dependent: :destroy

  require_human_on :create, if: :user_is_guest

  validates :discussion_category_id, :body, :title, presence: true

  scope :by_recency, -> { order('updated_at DESC') }
  scope :visible, -> { where(hidden: false) }
  scope :with_includes, -> { includes(:user).includes(:discussion_category) }

  def class_name
    'discussion'
  end

  def category_name
    discussion_category.name
  end

  def username
    if user_id?
      user.username
    else
      'Admin'
    end
  end

  private

  def user_is_guest
    user = User.where(id: self.user_id).first

    if Rails.env.test?
      false
    elsif guest_id
      true
    else
      !(user && user.logged_in?)
    end
  end
end