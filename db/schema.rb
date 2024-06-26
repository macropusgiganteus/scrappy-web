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

ActiveRecord::Schema[7.1].define(version: 2024_05_26_125541) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "keyword_results", force: :cascade do |t|
    t.bigint "keyword_id", null: false
    t.bigint "total_ads"
    t.bigint "total_links"
    t.string "total_search_results"
    t.string "html"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["keyword_id"], name: "index_keyword_results_on_keyword_id"
  end

  create_table "keywords", force: :cascade do |t|
    t.string "keyword"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_keywords_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "password_confirmation"
    t.datetime "last_signin_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "keyword_results", "keywords"
  add_foreign_key "keywords", "users"
end
