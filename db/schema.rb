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

ActiveRecord::Schema.define(version: 20150720202453) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bit_coupons", force: :cascade do |t|
    t.string   "private_key",             null: false
    t.string   "public_key",              null: false
    t.string   "address",                 null: false
    t.string   "coupon_code",             null: false
    t.integer  "btc_value",   default: 0
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "bit_coupons", ["coupon_code"], name: "index_bit_coupons_on_coupon_code", using: :btree

  create_table "blocks", force: :cascade do |t|
    t.string   "block_height", null: false
    t.string   "block_hash",   null: false
    t.datetime "date_posted"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "blocks", ["block_hash"], name: "index_blocks_on_block_hash", unique: true, using: :btree
  add_index "blocks", ["block_height"], name: "index_blocks_on_block_height", unique: true, using: :btree

  create_table "exchanges", force: :cascade do |t|
    t.string   "exchange_hash", null: false
    t.integer  "block_id",      null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "exchanges", ["exchange_hash"], name: "index_exchanges_on_exchange_hash", unique: true, using: :btree

  create_table "message_metadata", force: :cascade do |t|
    t.string   "iv"
    t.string   "salt"
    t.integer  "user_id",        null: false
    t.integer  "message_tag_id"
    t.integer  "exchange_id"
    t.datetime "date_posted"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "message_tags", force: :cascade do |t|
    t.string   "tag",        null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "exchange_id",            null: false
    t.string   "op_return_data_raw",     null: false
    t.string   "op_return_data_decoded", null: false
    t.string   "op_return_data_custom"
    t.integer  "message_tag_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "queued_messages", force: :cascade do |t|
    t.string   "raw_message",      null: false
    t.string   "hex_message",      null: false
    t.string   "message_encoding"
    t.integer  "bit_coupon_id"
    t.string   "tx_state",         null: false
    t.string   "tx_hash"
    t.integer  "tx_fee_btc"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: ""
    t.string   "encrypted_password",     default: "", null: false
    t.string   "username",               default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
