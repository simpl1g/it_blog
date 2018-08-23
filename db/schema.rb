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

ActiveRecord::Schema.define(version: 2018_08_23_144300) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ip_usages", force: :cascade do |t|
    t.inet "ip", null: false
    t.text "used_by", default: [], null: false, array: true
    t.index "array_upper(used_by, 1)", name: "ip_used_by_length"
    t.index ["ip"], name: "index_ip_usages_on_ip"
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "user_id"
    t.string "title", null: false
    t.text "body", null: false
    t.inet "ip", null: false
    t.integer "ranks_count", default: 0, null: false
    t.integer "ranks_sum", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "ranks", force: :cascade do |t|
    t.bigint "post_id"
    t.integer "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_ranks_on_post_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "login", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "posts", "users"
  add_foreign_key "ranks", "posts"
end
