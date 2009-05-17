# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090517034648) do

  create_table "comments", :force => true do |t|
    t.integer  "post_id",    :null => false
    t.string   "author",     :null => false
    t.string   "email",      :null => false
    t.string   "url"
    t.string   "body",       :null => false
    t.integer  "status",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menus", :force => true do |t|
    t.string   "name",                          :null => false
    t.string   "url",                           :null => false
    t.integer  "sort",       :default => 0,     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "new_window", :default => false, :null => false
  end

  create_table "pages", :force => true do |t|
    t.string   "title",      :null => false
    t.string   "slug",       :null => false
    t.string   "body",       :null => false
    t.integer  "status",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "post_fellow", :force => true do |t|
    t.string   "email",      :null => false
    t.integer  "post_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.string   "title",                           :null => false
    t.string   "slug",                            :null => false
    t.string   "body",                            :null => false
    t.integer  "status",                          :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "view_count",       :default => 0, :null => false
    t.integer  "comment_count",    :default => 0, :null => false
    t.string   "meta_keywords"
    t.string   "meta_description"
  end

  create_table "settings", :force => true do |t|
    t.string   "site_name"
    t.string   "sub_title"
    t.string   "email"
    t.string   "meta_keywords"
    t.string   "meta_description"
    t.string   "home_show"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fanfou_id"
    t.string   "blog_feed_html"
  end

  create_table "shares", :force => true do |t|
    t.string   "title",      :null => false
    t.string   "summary",    :null => false
    t.string   "from"
    t.string   "cover"
    t.string   "url",        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "uname",      :null => false
    t.string   "pwd",        :null => false
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
