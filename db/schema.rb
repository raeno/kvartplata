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

ActiveRecord::Schema.define(:version => 20130507191737) do

  create_table "apartment_infos", :force => true do |t|
    t.string   "owner"
    t.integer  "number"
    t.string   "address"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "metrics", :force => true do |t|
    t.decimal  "cold_counter_kitchen",  :precision => 16, :scale => 2
    t.decimal  "hot_counter_kitchen",   :precision => 16, :scale => 2
    t.decimal  "cold_counter_bathroom", :precision => 16, :scale => 2
    t.decimal  "hot_counter_bathroom",  :precision => 16, :scale => 2
    t.decimal  "energy_counter",        :precision => 16, :scale => 2
    t.datetime "month"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.integer  "report_id"
  end

  create_table "notification_settings", :force => true do |t|
    t.boolean  "notify_by_email"
    t.boolean  "notify_by_phone"
    t.integer  "user_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.boolean  "enabled"
    t.integer  "day"
    t.integer  "hour"
    t.integer  "minute"
  end

  create_table "reports", :force => true do |t|
    t.datetime "date"
    t.decimal  "cold_water",         :precision => 16, :scale => 2
    t.decimal  "hot_water",          :precision => 16, :scale => 2
    t.decimal  "utilities",          :precision => 16, :scale => 2
    t.decimal  "energy",             :precision => 16, :scale => 2
    t.decimal  "total",              :precision => 16, :scale => 2
    t.integer  "current_metric_id"
    t.integer  "previous_metric_id"
    t.integer  "tariff_id"
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
  end

  create_table "tariffs", :force => true do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.decimal  "cold_water", :precision => 16, :scale => 2
    t.decimal  "hot_water",  :precision => 16, :scale => 2
    t.decimal  "energy",     :precision => 16, :scale => 2
    t.decimal  "utilities",  :precision => 16, :scale => 2
    t.text     "comments"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                    :default => "", :null => false
    t.string   "encrypted_password",       :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",            :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.integer  "notification_settings_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
