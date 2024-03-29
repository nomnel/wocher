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

ActiveRecord::Schema.define(version: 2018_10_05_081417) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "hatena_bookmark_snapshots", force: :cascade do |t|
    t.bigint "page_id", null: false
    t.integer "count", default: 0, null: false
    t.date "date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date"], name: "index_hatena_bookmark_snapshots_on_date"
    t.index ["page_id"], name: "index_hatena_bookmark_snapshots_on_page_id"
  end

  create_table "pages", force: :cascade do |t|
    t.text "title", null: false
    t.text "url", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["url"], name: "index_pages_on_url", unique: true
  end

  add_foreign_key "hatena_bookmark_snapshots", "pages"
end
