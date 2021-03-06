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

ActiveRecord::Schema.define(version: 20161023122327) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "abuses", force: :cascade do |t|
    t.string   "email"
    t.string   "title"
    t.string   "referer"
    t.string   "description"
    t.boolean  "confirmed",     default: false
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
  end

  create_table "contributions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "pot_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "anonymous"
    t.string   "state"
    t.string   "amount_currency", default: "USD", null: false
    t.integer  "amount_cents",    default: 0,     null: false
    t.string   "payment_key"
    t.index ["pot_id"], name: "index_contributions_on_pot_id", using: :btree
    t.index ["user_id"], name: "index_contributions_on_user_id", using: :btree
  end

  create_table "friendships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend_id"], name: "index_friendships_on_friend_id", using: :btree
    t.index ["user_id"], name: "index_friendships_on_user_id", using: :btree
  end

  create_table "invitations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "pot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pot_id"], name: "index_invitations_on_pot_id", using: :btree
    t.index ["user_id"], name: "index_invitations_on_user_id", using: :btree
  end

  create_table "pots", force: :cascade do |t|
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.datetime "end_at"
    t.datetime "paid_at"
    t.boolean  "visible"
    t.text     "description"
    t.integer  "receiver_id"
    t.string   "currency"
    t.integer  "upper_bound_cents"
    t.string   "upper_bound_currency", default: "USD", null: false
    t.integer  "category",             default: 0
    t.index ["owner_id"], name: "index_pots_on_owner_id", using: :btree
    t.index ["receiver_id"], name: "index_pots_on_receiver_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "refresh_token"
    t.datetime "last_contact_sync_at"
    t.boolean  "admin",                  default: false, null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
