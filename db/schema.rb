# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_10_17_113036) do
  create_table "murmurs", force: :cascade do |t|
    t.text "content"
    t.string "location"
    t.integer "visibility"
    t.boolean "deleted"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_murmurs_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "nickname"
    t.date "birthday"
    t.integer "gender", default: 0
    t.integer "status", default: 0
    t.string "username"
    t.string "password_hash"
    t.string "email"
    t.boolean "email_confirmed", default: false
    t.string "mobile"
    t.string "wechat"
    t.string "weibo"
    t.string "avatar_url"
    t.datetime "member_since"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "murmurs", "users"
end
