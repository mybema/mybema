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

ActiveRecord::Schema.define(version: 20150112195307) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.string   "email",                  limit: 255
    t.string   "encrypted_password",     limit: 255, default: ""
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "invitation_token",       limit: 255
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type",        limit: 255
    t.integer  "invitations_count",                  default: 0
    t.string   "avatar",                 limit: 255
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["invitation_token"], name: "index_admins_on_invitation_token", unique: true, using: :btree
  add_index "admins", ["invitations_count"], name: "index_admins_on_invitations_count", using: :btree
  add_index "admins", ["invited_by_id"], name: "index_admins_on_invited_by_id", using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "app_settings", force: :cascade do |t|
    t.string   "all_articles_img",     limit: 255
    t.string   "all_discussions_img",  limit: 255
    t.string   "join_community_img",   limit: 255
    t.string   "new_discussion_img",   limit: 255
    t.string   "logo",                 limit: 255
    t.text     "hero_message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "seed_level",                       default: 0
    t.boolean  "guest_posting",                    default: true
    t.string   "ga_code",              limit: 255, default: ""
    t.string   "domain_address",       limit: 255, default: "example.com"
    t.string   "smtp_address",         limit: 255, default: ""
    t.integer  "smtp_port",                        default: 587
    t.string   "smtp_domain",          limit: 255, default: ""
    t.string   "smtp_username",        limit: 255, default: ""
    t.string   "smtp_password",        limit: 255, default: ""
    t.string   "mailer_sender",        limit: 255, default: "change-me@example.com"
    t.string   "mailer_reply_to",      limit: 255, default: "change-me@example.com"
    t.string   "welcome_mailer_copy",  limit: 255, default: "Hello {{USERNAME}}! \n\nThank you for signing up to our community!"
    t.string   "community_title",      limit: 255, default: "Mybema"
    t.string   "nav_bg_color",         limit: 255, default: "#333"
    t.string   "nav_link_color",       limit: 255, default: "#FFF"
    t.string   "nav_link_hover_color", limit: 255, default: "#212121"
  end

  create_table "articles", force: :cascade do |t|
    t.text     "body"
    t.string   "title",      limit: 255
    t.integer  "section_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "excerpt",    limit: 255
    t.string   "hero_image", limit: 255
  end

  add_index "articles", ["section_id"], name: "index_articles_on_section_id", using: :btree

  create_table "discussion_categories", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.string   "slug",              limit: 255
    t.text     "description"
    t.integer  "discussions_count",             default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "discussion_comments", force: :cascade do |t|
    t.text     "body"
    t.boolean  "hidden",                    default: false
    t.integer  "discussion_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "admin_id"
    t.string   "guest_id",      limit: 255
  end

  add_index "discussion_comments", ["admin_id"], name: "index_discussion_comments_on_admin_id", using: :btree
  add_index "discussion_comments", ["discussion_id"], name: "index_discussion_comments_on_discussion_id", using: :btree
  add_index "discussion_comments", ["user_id"], name: "index_discussion_comments_on_user_id", using: :btree

  create_table "discussions", force: :cascade do |t|
    t.text     "body"
    t.string   "title",                     limit: 255
    t.boolean  "hidden",                                default: false
    t.integer  "discussion_category_id"
    t.integer  "user_id"
    t.integer  "discussion_comments_count",             default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "guest_id",                  limit: 255
    t.integer  "admin_id"
    t.string   "slug",                      limit: 255
  end

  add_index "discussions", ["discussion_category_id"], name: "index_discussions_on_discussion_category_id", using: :btree
  add_index "discussions", ["user_id"], name: "index_discussions_on_user_id", using: :btree

  create_table "guidelines", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sections", force: :cascade do |t|
    t.string   "title",          limit: 255
    t.integer  "articles_count",             default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.string   "email",                  limit: 255
    t.string   "username",               limit: 255
    t.string   "ip_address",             limit: 255
    t.string   "guid",                   limit: 255
    t.boolean  "banned",                             default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "avatar",                 limit: 255
    t.text     "bio"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
