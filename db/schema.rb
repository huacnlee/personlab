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

ActiveRecord::Schema.define(:version => 20111025033816) do

  create_table "categories", :force => true do |t|
    t.string   "name",        :null => false
    t.string   "slug",        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "posts_count"
  end

  add_index "categories", ["slug"], :name => "index_categories_on_slug"

  create_table "comments", :force => true do |t|
    t.integer  "post_id",    :null => false
    t.string   "author",     :null => false
    t.string   "email",      :null => false
    t.string   "url"
    t.text     "body",       :null => false
    t.integer  "status",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_ip"
    t.string   "user_agent"
    t.string   "referrer"
  end

  add_index "comments", ["post_id"], :name => "index_comments_on_post_id"

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
    t.text     "body",       :null => false
    t.integer  "status",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["slug"], :name => "index_pages_on_slug"

  create_table "post_fellow", :force => true do |t|
    t.string   "email",      :null => false
    t.integer  "post_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.string   "title",                           :null => false
    t.string   "slug",                            :null => false
    t.text     "body",                            :null => false
    t.integer  "status",                          :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "view_count",       :default => 0, :null => false
    t.integer  "comment_count",    :default => 0, :null => false
    t.string   "meta_keywords"
    t.string   "meta_description"
    t.integer  "category_id"
  end

  add_index "posts", ["category_id"], :name => "index_posts_on_category_id"
  add_index "posts", ["slug"], :name => "index_posts_on_slug"
  add_index "posts", ["status"], :name => "index_posts_on_status"

  create_table "settings", :force => true do |t|
    t.string   "site_name"
    t.string   "sub_title"
    t.string   "email"
    t.string   "meta_keywords"
    t.string   "meta_description"
    t.text     "home_show"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "twitter_id"
    t.string   "google_reader_id"
    t.string   "disqus_shortname"
  end

  create_table "sitemap_settings", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "xml_location"
    t.string   "username"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sitemap_static_links", :force => true do |t|
    t.string   "url"
    t.string   "name"
    t.float    "priority"
    t.string   "frequency"
    t.string   "section"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sitemap_widgets", :force => true do |t|
    t.string   "widget_model"
    t.string   "index_named_route"
    t.string   "frequency_index"
    t.string   "frequency_show"
    t.float    "priority"
    t.string   "custom_finder"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "taggable_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "unfollowers", :force => true do |t|
    t.integer  "unfollowerable_id"
    t.string   "unfollowerable_type"
    t.string   "email",               :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "unfollowers", ["unfollowerable_id", "unfollowerable_type"], :name => "index_unfollowers_on_unfollowerable_id_and_unfollowerable_type"

  create_table "users", :force => true do |t|
    t.string   "uname",      :null => false
    t.string   "pwd",        :null => false
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
  end

end
