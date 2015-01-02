# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150102122633) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
    t.string   "avatar"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["invitation_token"], name: "index_admins_on_invitation_token", unique: true, using: :btree
  add_index "admins", ["invitations_count"], name: "index_admins_on_invitations_count", using: :btree
  add_index "admins", ["invited_by_id"], name: "index_admins_on_invited_by_id", using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "app_settings", force: true do |t|
    t.string   "all_articles_img"
    t.string   "all_discussions_img"
    t.string   "join_community_img"
    t.string   "new_discussion_img"
    t.string   "logo"
    t.text     "hero_message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "seed_level",          default: 0
    t.boolean  "guest_posting",       default: true
    t.string   "ga_code",             default: ""
    t.string   "domain_address",      default: "example.com"
    t.string   "smtp_address",        default: ""
    t.integer  "smtp_port",           default: 587
    t.string   "smtp_domain",         default: ""
    t.string   "smtp_username",       default: ""
    t.string   "smtp_password",       default: ""
    t.string   "mailer_sender",       default: "change-me@example.com"
    t.string   "mailer_reply_to",     default: "change-me@example.com"
    t.string   "welcome_mailer_copy", default: "Hello {{USERNAME}}! \n\nThank you for signing up to our community!"
  end

  create_table "articles", force: true do |t|
    t.text     "body"
    t.string   "title"
    t.integer  "section_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "articles", ["section_id"], name: "index_articles_on_section_id", using: :btree

  create_table "discussion_categories", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.text     "description"
    t.integer  "discussions_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "discussion_comments", force: true do |t|
    t.text     "body"
    t.boolean  "hidden",        default: false
    t.integer  "discussion_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "admin_id"
    t.string   "guest_id"
  end

  add_index "discussion_comments", ["admin_id"], name: "index_discussion_comments_on_admin_id", using: :btree
  add_index "discussion_comments", ["discussion_id"], name: "index_discussion_comments_on_discussion_id", using: :btree
  add_index "discussion_comments", ["user_id"], name: "index_discussion_comments_on_user_id", using: :btree

  create_table "discussions", force: true do |t|
    t.text     "body"
    t.string   "title"
    t.boolean  "hidden",                    default: false
    t.integer  "discussion_category_id"
    t.integer  "user_id"
    t.integer  "discussion_comments_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "guest_id"
    t.integer  "admin_id"
    t.string   "slug"
  end

  add_index "discussions", ["discussion_category_id"], name: "index_discussions_on_discussion_category_id", using: :btree
  add_index "discussions", ["user_id"], name: "index_discussions_on_user_id", using: :btree

  create_table "guidelines", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sections", force: true do |t|
    t.string   "title"
    t.integer  "articles_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "username"
    t.string   "ip_address"
    t.string   "guid"
    t.boolean  "banned",                 default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "avatar"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
