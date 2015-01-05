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
#  community_title     :string(255)      default("Mybema")
#

FactoryGirl.define do
  factory :app_settings do
    hero_message { Faker::Lorem.sentence(10) }
  end
end
