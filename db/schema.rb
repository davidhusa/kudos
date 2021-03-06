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

ActiveRecord::Schema.define(version: 20161221211553) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "name"
    t.text     "about"
    t.string   "default_role"
    t.string   "status"
    t.integer  "user_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.index ["user_id"], name: "index_accounts_on_user_id", using: :btree
  end

  create_table "accounts_teams", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id", "team_id"], name: "index_accounts_teams_on_account_id_and_team_id", unique: true, using: :btree
    t.index ["account_id"], name: "index_accounts_teams_on_account_id", using: :btree
    t.index ["team_id"], name: "index_accounts_teams_on_team_id", using: :btree
  end

  create_table "kudos", force: :cascade do |t|
    t.integer  "to_id"
    t.integer  "from_id"
    t.string   "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "sprint"
    t.integer  "team_id"
    t.index ["from_id"], name: "index_kudos_on_from_id", using: :btree
    t.index ["team_id"], name: "index_kudos_on_team_id", using: :btree
    t.index ["to_id"], name: "index_kudos_on_to_id", using: :btree
  end

  create_table "teams", force: :cascade do |t|
    t.integer  "leader_id"
    t.string   "name"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "sprint",      default: 0
    t.date     "start_date"
    t.integer  "sprint_days", default: 7
    t.index ["leader_id"], name: "index_teams_on_leader_id", using: :btree
  end

  create_table "totals", force: :cascade do |t|
    t.integer  "to_id"
    t.integer  "from_id"
    t.integer  "kudos",      default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "team_id"
    t.index ["from_id"], name: "index_totals_on_from_id", using: :btree
    t.index ["team_id"], name: "index_totals_on_team_id", using: :btree
    t.index ["to_id", "from_id"], name: "index_totals_on_to_id_and_from_id", using: :btree
    t.index ["to_id"], name: "index_totals_on_to_id", using: :btree
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
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.boolean  "admin",                  default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "accounts_teams", "accounts"
  add_foreign_key "accounts_teams", "teams"
  add_foreign_key "kudos", "accounts", column: "from_id"
  add_foreign_key "kudos", "accounts", column: "to_id"
  add_foreign_key "teams", "accounts", column: "leader_id"
  add_foreign_key "totals", "accounts", column: "from_id"
  add_foreign_key "totals", "accounts", column: "to_id"
end
