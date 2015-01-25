# == Schema Information
#
# Table name: discussions
#
#  id                        :integer          not null, primary key
#  body                      :text
#  title                     :string(255)
#  hidden                    :boolean          default("false")
#  discussion_category_id    :integer
#  user_id                   :integer
#  discussion_comments_count :integer          default("0")
#  created_at                :datetime
#  updated_at                :datetime
#  guest_id                  :string(255)
#  admin_id                  :integer
#  slug                      :string(255)
#

class Discussion < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include UserDetails
  include Humanizer

  index_name "discussion_#{Rails.env}"

  belongs_to :discussion_category, counter_cache: true
  belongs_to :user
  belongs_to :admin
  has_many :discussion_comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  require_human_on :create, if: :user_is_guest

  before_save :sluggify_title

  validates :discussion_category_id, :body, :title, presence: true
  validates_uniqueness_of :title

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
      admin.username
    end
  end

  private

  def sluggify_title
    self.slug = title.parameterize
  end
end
