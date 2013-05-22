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

ActiveRecord::Schema.define(:version => 20130330152808) do

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "ready",            :default => false
    t.string   "subtitle"
    t.string   "meta_title"
    t.string   "meta_keywords"
    t.string   "meta_description"
    t.string   "slug"
  end

  add_index "articles", ["slug"], :name => "index_articles_on_slug"

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "alias"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "list_order"
  end

  create_table "categories_products", :id => false, :force => true do |t|
    t.integer "category_id"
    t.integer "product_id"
  end

  create_table "clients", :force => true do |t|
    t.boolean  "private"
    t.string   "email"
    t.string   "telephone"
    t.string   "name"
    t.string   "last_name"
    t.string   "street"
    t.string   "city"
    t.string   "code"
    t.string   "company"
    t.string   "company_nip"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "crypted_password",                      :null => false
    t.string   "password_salt",                         :null => false
    t.string   "persistence_token",                     :null => false
    t.string   "single_access_token",                   :null => false
    t.string   "perishable_token",                      :null => false
    t.integer  "login_count",         :default => 0,    :null => false
    t.integer  "failed_login_count",  :default => 0,    :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.boolean  "agreement",           :default => true
    t.string   "building_no"
    t.string   "place_no"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "entries", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "meta_title"
    t.string   "meta_keywords"
    t.string   "meta_description"
    t.integer  "category_id"
  end

  create_table "mercury_images", :force => true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "messages", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
    t.integer  "client_id"
  end

  add_index "messages", ["client_id"], :name => "index_messages_on_client_id"
  add_index "messages", ["user_id"], :name => "index_messages_on_user_id"

  create_table "order_items", :force => true do |t|
    t.integer  "product_id"
    t.integer  "order_id"
    t.integer  "quantity"
    t.text     "notice"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.string   "number"
    t.integer  "client_id"
    t.text     "notice"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",           :default => 0
    t.string   "building_no"
    t.string   "place_no"
    t.string   "street"
    t.string   "city"
    t.string   "code"
    t.integer  "payment",          :default => 0
    t.string   "full_name"
    t.string   "email"
    t.boolean  "agreement",        :default => true
    t.string   "delivery_method",  :default => "Poczta Polska"
    t.string   "delivery_info"
    t.decimal  "total"
    t.decimal  "delivery_payment"
    t.integer  "pack_machine_id"
  end

  create_table "pack_machines", :force => true do |t|
    t.string   "name"
    t.string   "province"
    t.string   "postcode"
    t.string   "town"
    t.string   "street"
    t.string   "building_number"
    t.string   "latitude"
    t.string   "longitude"
    t.string   "status"
    t.string   "location_description"
    t.string   "operating_hours"
    t.string   "payment_point_description"
    t.string   "partner_id"
    t.string   "payment_type"
    t.string   "payment_available"
    t.string   "machine_type"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "photos", :force => true do |t|
    t.integer  "product_id"
    t.string   "title",                                 :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "rotator",            :default => false
    t.integer  "rotator_order"
    t.string   "rotator_link"
    t.integer  "article_id"
  end

  create_table "producers", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "email"
    t.string   "telephone"
    t.string   "www"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "priority",    :default => 1000
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "producer_id"
    t.integer  "category_id"
    t.decimal  "price",            :precision => 8, :scale => 2
    t.integer  "discount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_promotion"
    t.decimal  "promotion_price",  :precision => 8, :scale => 2
    t.string   "promotion_text"
    t.string   "author"
    t.string   "book_format"
    t.integer  "page_count"
    t.boolean  "visible",                                        :default => true
    t.string   "meta_title"
    t.string   "meta_keywords"
    t.string   "meta_description"
    t.string   "slug"
    t.integer  "hits_quantity",                                  :default => 0
    t.decimal  "final_price",                                    :default => 0.0
  end

  add_index "products", ["slug"], :name => "index_products_on_slug"

  create_table "products_relations", :id => false, :force => true do |t|
    t.integer "product_id",  :null => false
    t.integer "relation_id", :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password"
    t.string   "name"
    t.string   "last_name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "crypted_password",                   :null => false
    t.string   "password_salt",                      :null => false
    t.string   "persistence_token",                  :null => false
    t.string   "single_access_token",                :null => false
    t.string   "perishable_token",                   :null => false
    t.integer  "login_count",         :default => 0, :null => false
    t.integer  "failed_login_count",  :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
  end

end
