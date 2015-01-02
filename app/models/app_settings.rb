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
#  ga_code             :string(255)      default("")
#  domain_address      :string(255)      default("example.com")
#  smtp_address        :string(255)      default("")
#  smtp_port           :integer          default(587)
#  smtp_domain         :string(255)      default("")
#  smtp_username       :string(255)      default("")
#  smtp_password       :string(255)      default("")
#  mailer_sender       :string(255)      default("change-me@example.com")
#  mailer_reply_to     :string(255)      default("change-me@example.com")
#  welcome_mailer_copy :string(255)      default("Hello {{USERNAME}}! \n\nThank you for signing up to our community!")
#

class AppSettings < ActiveRecord::Base
  mount_uploader :all_articles_img, AllArticlesImageUploader
  mount_uploader :all_discussions_img, AllDiscussionsImageUploader
  mount_uploader :join_community_img, JoinCommunityImageUploader
  mount_uploader :new_discussion_img, NewDiscussionImageUploader
  mount_uploader :logo, LogoUploader

  validates_presence_of :hero_message

  def all_articles_image
    if all_articles_img.present?
      all_articles_img.url
    else
      all_articles_img.default_url
    end
  end

  def all_discussions_image
    if all_discussions_img.present?
      all_discussions_img.url
    else
      all_discussions_img.default_url
    end
  end

  def join_community_image
    if join_community_img.present?
      join_community_img.url
    else
      join_community_img.default_url
    end
  end

  def new_discussion_image
    if new_discussion_img.present?
      new_discussion_img.url
    else
      new_discussion_img.default_url
    end
  end

  def logo_image
    if logo.present?
      logo.url
    else
      logo.default_url
    end
  end
end
