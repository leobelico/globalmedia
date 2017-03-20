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

ActiveRecord::Schema.define(version: 20170320134941) do

  create_table "articles", force: :cascade do |t|
    t.string   "name",              default: ""
    t.text     "note",              default: ""
    t.text     "short_description", default: ""
    t.integer  "articable_id"
    t.string   "articable_type"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "slug",              default: ""
    t.index ["articable_type", "articable_id"], name: "index_articles_on_articable_type_and_articable_id"
  end

  create_table "articles_hashtags", force: :cascade do |t|
    t.integer  "hashtag_id"
    t.integer  "article_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hashtags", force: :cascade do |t|
    t.string   "name",       default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "highlights", force: :cascade do |t|
    t.integer  "order",      default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "article_id"
    t.index ["article_id"], name: "index_highlights_on_article_id"
  end

  create_table "sections", force: :cascade do |t|
    t.string   "name",       default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

end
