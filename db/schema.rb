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

ActiveRecord::Schema.define(:version => 20130624010831) do

  create_table "authorizations", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "token"
    t.string   "secret"
  end

  create_table "cohorts", :force => true do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "display",    :default => false
  end

  add_index "cohorts", ["end_date"], :name => "index_cohorts_on_end_date"
  add_index "cohorts", ["start_date"], :name => "index_cohorts_on_start_date"

  create_table "commitments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "cohort_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "commitments", ["cohort_id"], :name => "index_commitments_on_cohort_id"
  add_index "commitments", ["user_id", "cohort_id"], :name => "index_commitments_on_user_id_and_cohort_id"
  add_index "commitments", ["user_id"], :name => "index_commitments_on_user_id"

  create_table "pairings", :force => true do |t|
    t.integer  "mentor_id"
    t.integer  "mentee_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "pairings", ["mentee_id"], :name => "index_pairings_on_mentee_id"
  add_index "pairings", ["mentor_id", "mentee_id"], :name => "index_pairings_on_mentor_id_and_mentee_id", :unique => true
  add_index "pairings", ["mentor_id"], :name => "index_pairings_on_mentor_id"

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "role"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "pic"
    t.string   "contact_phone"
    t.string   "contact_email"
    t.boolean  "active"
    t.boolean  "deleted"
    t.integer  "cohort_id"
    t.string   "twitter"
    t.string   "company"
    t.string   "linkedin"
    t.string   "location"
    t.text     "passions"
    t.text     "interests"
    t.string   "title"
    t.string   "repo"
    t.boolean  "employment_agreement"
    t.boolean  "admin"
  end

  add_index "users", ["role"], :name => "index_users_on_role"

end
