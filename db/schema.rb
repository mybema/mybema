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

ActiveRecord::Schema.define(version: 20140726123210) do

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
  end

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
  end

  add_index "discussions", ["discussion_category_id"], name: "index_discussions_on_discussion_category_id", using: :btree
  add_index "discussions", ["user_id"], name: "index_discussions_on_user_id", using: :btree

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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
