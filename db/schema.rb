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

ActiveRecord::Schema.define(version: 20150716182503) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blocks", force: :cascade do |t|
    t.string   "block_height"
    t.string   "block_hash"
    t.datetime "parsed_date"
    t.datetime "date_posted"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "blocks", ["block_hash"], name: "index_blocks_on_block_hash", using: :btree
  add_index "blocks", ["block_height"], name: "index_blocks_on_block_height", using: :btree

  create_table "message_metadata", force: :cascade do |t|
    t.string   "iv"
    t.string   "salt"
    t.integer  "user_id"
    t.integer  "message_tag_id"
    t.string   "transaction_id"
    t.datetime "date_posted"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "message_tags", force: :cascade do |t|
    t.string   "tag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.string   "transaction_id"
    t.string   "op_return_data_raw"
    t.string   "op_return_data_decoded"
    t.datetime "date_posted"
    t.integer  "message_tag_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.string   "tx_hash"
    t.integer  "block_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "transactions", ["tx_hash"], name: "index_transactions_on_tx_hash", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: ""
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "username",                            null: false
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
