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

ActiveRecord::Schema.define(version: 2019_08_19_115109) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_keys", force: :cascade do |t|
    t.string "access_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "title"
    t.string "subtitle"
    t.string "image_url"
    t.string "main_image_url"
    t.integer "position", default: 0
    t.boolean "onboarding", default: false
    t.boolean "default_sounds_title", default: false
    t.boolean "deleted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_sounds", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "sound_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position", default: 0
    t.boolean "lock", default: false
    t.index ["category_id"], name: "index_category_sounds_on_category_id"
    t.index ["sound_id"], name: "index_category_sounds_on_sound_id"
  end

  create_table "mix_categories", force: :cascade do |t|
    t.bigint "mix_id"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_mix_categories_on_category_id"
    t.index ["mix_id"], name: "index_mix_categories_on_mix_id"
  end

  create_table "mix_sounds", force: :cascade do |t|
    t.bigint "mix_id"
    t.bigint "sound_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mix_id"], name: "index_mix_sounds_on_mix_id"
    t.index ["sound_id"], name: "index_mix_sounds_on_sound_id"
  end

  create_table "mixes", force: :cascade do |t|
    t.string "name"
    t.string "image_url"
    t.boolean "paid", default: false
    t.integer "duration"
    t.integer "position", default: 0
    t.integer "volume", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pictures", force: :cascade do |t|
    t.string "body_image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string "image_url"
    t.string "title"
    t.text "body"
    t.integer "position", default: 0
    t.string "publication"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
  end

  create_table "purchases", force: :cascade do |t|
    t.string "product_id"
    t.string "store"
    t.string "currency"
    t.float "currency_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sounds", force: :cascade do |t|
    t.string "image_url"
    t.string "file_url"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "deleted", default: false
    t.boolean "popular", default: false
  end

  create_table "user_purchases", force: :cascade do |t|
    t.string "appsflyer_id"
    t.string "receipt"
    t.string "store"
    t.string "event_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "product_id"
    t.integer "application_version"
    t.boolean "is_trial_period"
    t.datetime "expires_date_ms"
    t.string "latest_receipt"
  end

  create_table "users", force: :cascade do |t|
    t.string "firs_name"
    t.string "last_name"
    t.string "email", default: "", null: false
    t.string "roles"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "category_sounds", "categories"
  add_foreign_key "category_sounds", "sounds"
end
