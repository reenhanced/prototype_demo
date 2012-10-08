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

ActiveRecord::Schema.define(:version => 20121005133656) do

  create_table "audits", :force => true do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "associated_id"
    t.string   "associated_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "audited_changes"
    t.integer  "version",         :default => 0
    t.string   "comment"
    t.string   "remote_address"
    t.datetime "created_at"
  end

  add_index "audits", ["associated_id", "associated_type"], :name => "associated_index"
  add_index "audits", ["auditable_id", "auditable_type"], :name => "auditable_index"
  add_index "audits", ["created_at"], :name => "index_audits_on_created_at"
  add_index "audits", ["user_id", "user_type"], :name => "user_index"

  create_table "call_logs", :force => true do |t|
    t.integer  "family_card_id"
    t.text     "message"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "contact_id"
    t.string   "contact_type"
    t.datetime "recorded_at"
  end

  create_table "family_card_qualifiers", :force => true do |t|
    t.integer  "family_card_id"
    t.integer  "qualifier_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "family_card_qualifiers", ["family_card_id"], :name => "index_family_card_qualifiers_on_family_card_id"
  add_index "family_card_qualifiers", ["qualifier_id"], :name => "index_family_card_qualifiers_on_qualifier_id"

  create_table "family_cards", :force => true do |t|
    t.integer  "primary_parent_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "user_id"
  end

  add_index "family_cards", ["user_id"], :name => "index_family_cards_on_user_id"

  create_table "family_members", :force => true do |t|
    t.string   "type"
    t.integer  "family_card_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "gender",          :limit => 1
    t.string   "phone"
    t.string   "email"
    t.date     "birthday"
    t.integer  "graduation_year"
    t.string   "relationship"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "family_members", ["family_card_id"], :name => "index_family_members_on_family_card_id"

  create_table "qualifiers", :force => true do |t|
    t.string   "name"
    t.string   "category"
    t.integer  "position",   :default => 0
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
