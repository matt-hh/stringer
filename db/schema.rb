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

ActiveRecord::Schema[7.0].define(version: 2023_03_01_024452) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0
    t.integer "attempts", default: 0
    t.text "handler"
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "feeds", force: :cascade do |t|
    t.string "name"
    t.text "url"
    t.datetime "last_fetched"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "status"
    t.integer "group_id"
    t.bigint "user_id", null: false
    t.index ["url", "user_id"], name: "index_feeds_on_url_and_user_id", unique: true
    t.index ["user_id"], name: "index_feeds_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["name", "user_id"], name: "index_groups_on_name_and_user_id", unique: true
    t.index ["user_id"], name: "index_groups_on_user_id"
  end

  create_table "stories", force: :cascade do |t|
    t.text "title"
    t.text "permalink"
    t.text "body"
    t.integer "feed_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "published"
    t.boolean "is_read"
    t.boolean "keep_unread", default: false
    t.boolean "is_starred", default: false
    t.text "entry_id"
    t.string "enclosure_url"
    t.index ["entry_id", "feed_id"], name: "index_stories_on_entry_id_and_feed_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "api_key", null: false
    t.string "username", null: false
    t.index ["api_key"], name: "index_users_on_api_key", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "feeds", "users"
  add_foreign_key "groups", "users"
end
