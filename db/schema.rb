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

ActiveRecord::Schema.define(version: 20170413154207) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string   "name",                  default: ""
    t.text     "note",                  default: ""
    t.text     "short_description",     default: ""
    t.integer  "articable_id"
    t.string   "articable_type"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "slug",                  default: ""
    t.integer  "keyword_id"
    t.boolean  "highlight",             default: false
    t.boolean  "global_recommendation", default: false
    t.integer  "user_id"
    t.index ["articable_type", "articable_id"], name: "index_articles_on_articable_type_and_articable_id", using: :btree
    t.index ["keyword_id"], name: "index_articles_on_keyword_id", using: :btree
    t.index ["user_id"], name: "index_articles_on_user_id", using: :btree
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
    t.index ["article_id"], name: "index_highlights_on_article_id", using: :btree
  end

  create_table "hits", force: :cascade do |t|
    t.integer  "number",     default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "article_id"
    t.index ["article_id"], name: "index_hits_on_article_id", using: :btree
  end

  create_table "keywords", force: :cascade do |t|
    t.string   "keyword",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "slug",       default: ""
  end

  create_table "section_highlights", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "section_id"
    t.integer  "article_id"
    t.index ["article_id"], name: "index_section_highlights_on_article_id", using: :btree
    t.index ["section_id"], name: "index_section_highlights_on_section_id", using: :btree
  end

  create_table "sections", force: :cascade do |t|
    t.string   "name",       default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "slug"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "first_name",             default: ""
    t.string   "last_name",              default: ""
    t.string   "full_name",              default: ""
    t.string   "role",                   default: ""
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "articles", "keywords"
  add_foreign_key "articles", "users"
  add_foreign_key "highlights", "articles"
  add_foreign_key "hits", "articles"
  add_foreign_key "section_highlights", "articles"
  add_foreign_key "section_highlights", "sections"
end
