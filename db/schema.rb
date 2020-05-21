# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_21_150957) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "article_relationships", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "article_id"
    t.string "articable_type"
    t.integer "articable_id"
    t.index ["articable_type", "articable_id"], name: "index_article_relationships_on_articable_type_and_articable_id"
    t.index ["article_id"], name: "index_article_relationships_on_article_id"
  end

  create_table "articles", id: :serial, force: :cascade do |t|
    t.string "name", default: ""
    t.jsonb "note", default: ""
    t.text "short_description", default: ""
    t.integer "articable_id"
    t.string "articable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug", default: ""
    t.integer "keyword_id"
    t.boolean "highlight", default: false
    t.boolean "global_recommendation", default: false
    t.integer "user_id"
    t.string "plain_text"
    t.datetime "updated_recommendation_on"
    t.string "image_thumbnail"
    t.string "image"
    t.integer "draft", default: 0
    t.boolean "published", default: false
    t.datetime "scheduled_time"
    t.string "video_url", default: ""
    t.integer "author_id"
    t.boolean "exclusive", default: false
    t.text "_extra_props"
    t.boolean "breaking_news"
    t.datetime "published_at"
    t.index ["articable_id"], name: "index_articles_on_articable_id"
    t.index ["articable_type", "articable_id"], name: "index_articles_on_articable_type_and_articable_id"
    t.index ["author_id"], name: "index_articles_on_author_id"
    t.index ["keyword_id"], name: "index_articles_on_keyword_id"
    t.index ["slug"], name: "index_articles_on_slug"
    t.index ["user_id"], name: "index_articles_on_user_id"
  end

  create_table "articles_hashtags", id: :serial, force: :cascade do |t|
    t.integer "hashtag_id"
    t.integer "article_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "authors", id: :serial, force: :cascade do |t|
    t.string "name", default: ""
    t.string "logo", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "banners", id: :serial, force: :cascade do |t|
    t.string "large_image", default: ""
    t.string "small_image", default: ""
    t.string "size", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", default: ""
    t.boolean "global", default: false
    t.boolean "titlepage", default: false
    t.string "client"
    t.string "url"
    t.boolean "active", default: false
    t.datetime "expiry_date"
  end

  create_table "cameras", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.string "lat"
    t.string "lng"
    t.string "stream"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cover"
  end

  create_table "controls", id: :serial, force: :cascade do |t|
    t.datetime "init_date"
    t.datetime "end_date"
    t.string "client_name", default: ""
    t.string "event_name", default: ""
    t.string "event_address", default: ""
    t.string "station_name", default: ""
    t.string "unit_name", default: ""
    t.text "techs", default: ""
    t.text "observations", default: ""
    t.string "contract_number", default: ""
    t.string "contract_state", default: ""
    t.string "agent_name", default: ""
    t.boolean "datasheet", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cover_articles", id: :serial, force: :cascade do |t|
    t.string "name", default: ""
    t.string "article_slug", default: ""
    t.string "article_image", default: ""
    t.integer "section_id"
    t.integer "article_id"
    t.boolean "article_highlight", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "published_at"
    t.string "section_slug"
    t.string "section_name"
    t.string "section_description"
    t.string "section_color"
    t.boolean "article_exclusive", default: false
  end

  create_table "devices", id: :serial, force: :cascade do |t|
    t.string "token"
    t.string "operating_system"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "global_recommendation_articles", id: :serial, force: :cascade do |t|
    t.string "name", default: ""
    t.string "article_slug", default: ""
    t.string "article_image", default: ""
    t.integer "section_id"
    t.boolean "global_recommendation", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "article_id"
  end

  create_table "hashtags", id: :serial, force: :cascade do |t|
    t.string "name", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "selected", default: false
    t.datetime "selected_on"
  end

  create_table "highlights", id: :serial, force: :cascade do |t|
    t.integer "order", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "article_id"
    t.datetime "scheduled_time"
    t.boolean "published", default: false
    t.index ["article_id"], name: "index_highlights_on_article_id"
  end

  create_table "hit_objectives", id: :serial, force: :cascade do |t|
    t.integer "objective", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "section_id"
    t.integer "author_id"
    t.integer "user_id"
    t.index ["author_id"], name: "index_hit_objectives_on_author_id"
    t.index ["section_id"], name: "index_hit_objectives_on_section_id"
    t.index ["user_id"], name: "index_hit_objectives_on_user_id"
  end

  create_table "hits", id: :serial, force: :cascade do |t|
    t.integer "number", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "article_id"
    t.index ["article_id"], name: "index_hits_on_article_id"
  end

  create_table "images", id: :serial, force: :cascade do |t|
    t.string "src"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "article_id"
    t.text "_extra_props"
    t.index ["article_id"], name: "index_images_on_article_id"
  end

  create_table "keywords", id: :serial, force: :cascade do |t|
    t.string "keyword", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug", default: ""
  end

  create_table "latest_articles", id: :serial, force: :cascade do |t|
    t.string "name", default: ""
    t.string "article_slug", default: ""
    t.string "section_name", default: ""
    t.string "section_slug", default: ""
    t.integer "article_id"
    t.datetime "published_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "most_visited_articles", id: :serial, force: :cascade do |t|
    t.string "name", default: ""
    t.string "article_slug", default: ""
    t.string "article_image", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "article_id"
  end

  create_table "new_banners", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "banner_type", null: false
    t.text "content", null: false
    t.boolean "is_active", default: false, null: false
    t.datetime "show_at", null: false
    t.datetime "expiry_at", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "notifications", id: :serial, force: :cascade do |t|
    t.string "title"
    t.string "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "key", default: ""
    t.string "key_id", default: ""
    t.boolean "wants_keys", default: false
  end

  create_table "podcasts", id: :serial, force: :cascade do |t|
    t.string "name", default: ""
    t.string "stream_url", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "station_id"
    t.string "description", default: ""
    t.index ["station_id"], name: "index_podcasts_on_station_id"
  end

  create_table "related_sections", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "section_reference_id"
    t.integer "section_id"
    t.index ["section_id"], name: "index_related_sections_on_section_id"
    t.index ["section_reference_id"], name: "index_related_sections_on_section_reference_id"
  end

  create_table "relationships", id: :serial, force: :cascade do |t|
    t.string "name", default: ""
    t.string "image", default: ""
    t.text "description", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug", default: ""
    t.string "relationship_type", default: ""
  end

  create_table "section_banners", id: :serial, force: :cascade do |t|
    t.integer "sectionable_id"
    t.string "sectionable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "banner_id"
    t.index ["banner_id"], name: "index_section_banners_on_banner_id"
    t.index ["sectionable_type", "sectionable_id"], name: "index_section_banners_on_sectionable_type_and_sectionable_id"
  end

  create_table "section_highlights", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "section_id"
    t.integer "article_id"
    t.index ["article_id"], name: "index_section_highlights_on_article_id"
    t.index ["section_id"], name: "index_section_highlights_on_section_id"
  end

  create_table "sections", id: :serial, force: :cascade do |t|
    t.string "name", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.string "color", default: "#1b2d41"
    t.integer "order"
    t.text "_extra_props"
    t.boolean "visible", default: false
    t.text "description"
    t.string "facebook"
    t.string "twitter"
  end

  create_table "sports", id: :serial, force: :cascade do |t|
    t.string "team_one"
    t.string "team_two"
    t.string "team_one_image"
    t.string "team_two_image"
    t.string "team_one_score"
    t.string "team_two_score"
    t.string "team_one_goal_scorers"
    t.string "team_two_goal_scorers"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stations", id: :serial, force: :cascade do |t|
    t.string "name", default: ""
    t.string "stream_url", default: ""
    t.string "image", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug", default: ""
    t.string "twitter"
    t.string "facebook"
    t.boolean "video", default: false
    t.string "playlist_1", default: ""
    t.string "playlist_2", default: ""
    t.string "playlist_3", default: ""
    t.string "playlist_4", default: ""
    t.string "playlist_1_image", default: ""
    t.string "playlist_2_image", default: ""
    t.string "playlist_3_image", default: ""
    t.string "playlist_4_image", default: ""
    t.boolean "news", default: false
    t.float "frequency", default: 0.0
    t.text "description", default: ""
    t.string "image_preview", default: ""
    t.string "app_url", default: ""
  end

  create_table "timetables", id: :serial, force: :cascade do |t|
    t.time "streaming_hour"
    t.string "name", default: ""
    t.string "image", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "station_id"
    t.time "end_streaming_hour"
    t.boolean "monday", default: false
    t.boolean "tuesday", default: false
    t.boolean "wednesday", default: false
    t.boolean "thursday", default: false
    t.boolean "friday", default: false
    t.boolean "saturday", default: false
    t.boolean "sunday", default: false
    t.string "broadcasters"
    t.string "broadcaster_image"
    t.text "description", default: ""
    t.index ["station_id"], name: "index_timetables_on_station_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "first_name", default: ""
    t.string "last_name", default: ""
    t.string "full_name", default: ""
    t.string "role", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "banners_permission", default: false
    t.boolean "create_articles_permission", default: false
    t.boolean "video_complaints_permission", default: false
    t.boolean "hits_permission", default: false
    t.boolean "destroy_articles_permission", default: false
    t.boolean "radio_stations_permission", default: false
    t.boolean "remote_controls_permission", default: false
    t.boolean "user_permission", default: false
    t.boolean "is_news_chief", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "article_relationships", "articles"
  add_foreign_key "articles", "authors"
  add_foreign_key "articles", "keywords"
  add_foreign_key "articles", "users"
  add_foreign_key "highlights", "articles"
  add_foreign_key "hit_objectives", "authors"
  add_foreign_key "hit_objectives", "sections"
  add_foreign_key "hit_objectives", "users"
  add_foreign_key "hits", "articles"
  add_foreign_key "images", "articles"
  add_foreign_key "podcasts", "stations"
  add_foreign_key "related_sections", "sections"
  add_foreign_key "related_sections", "sections", column: "section_reference_id"
  add_foreign_key "section_banners", "banners"
  add_foreign_key "section_highlights", "articles"
  add_foreign_key "section_highlights", "sections"
  add_foreign_key "timetables", "stations"
end
