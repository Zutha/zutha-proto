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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120607083941) do

  create_table "investments", :force => true do |t|
    t.float    "h",          :default => 0.0, :null => false
    t.integer  "user_id"
    t.integer  "item_id"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "investments", ["item_id"], :name => "index_investments_on_item_id"
  add_index "investments", ["user_id"], :name => "index_investments_on_user_id"

  create_table "items", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.float    "worth",             :default => 0.0
    t.float    "pos_market_height", :default => 0.0
    t.string   "url"
  end

  create_table "tag_links", :force => true do |t|
    t.integer  "tag_id",     :null => false
    t.integer  "item_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "tag_links", ["item_id"], :name => "index_tag_links_on_item_id"
  add_index "tag_links", ["tag_id"], :name => "index_tag_links_on_tag_id"

  create_table "tag_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tags", :force => true do |t|
    t.string   "name",        :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "tag_type_id"
  end

  add_index "tags", ["name"], :name => "index_tags_on_name", :unique => true

  create_table "users", :force => true do |t|
    t.string   "name"
    t.float    "reputation",          :default => 0.0, :null => false
    t.float    "zuth",                :default => 0.0, :null => false
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.string   "email",               :default => ""
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "identifier"
    t.boolean  "admin"
  end

  add_index "users", ["identifier"], :name => "index_users_on_identifier", :unique => true

end
