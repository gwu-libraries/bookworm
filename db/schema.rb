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

ActiveRecord::Schema[7.1].define(version: 2024_07_09_200009) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "author_works", force: :cascade do |t|
    t.bigint "author_id", null: false
    t.bigint "work_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_author_works_on_author_id"
    t.index ["work_id"], name: "index_author_works_on_work_id"
  end

  create_table "authors", force: :cascade do |t|
    t.string "name"
    t.string "orcid"
    t.string "openalex_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "connections", force: :cascade do |t|
    t.integer "reference_id", null: false
    t.integer "citation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "investigation_authors", force: :cascade do |t|
    t.bigint "investigation_id", null: false
    t.bigint "author_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_investigation_authors_on_author_id"
    t.index ["investigation_id"], name: "index_investigation_authors_on_investigation_id"
  end

  create_table "investigation_works", force: :cascade do |t|
    t.bigint "investigation_id", null: false
    t.bigint "work_id", null: false
    t.boolean "root_work", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["investigation_id"], name: "index_investigation_works_on_investigation_id"
    t.index ["work_id"], name: "index_investigation_works_on_work_id"
  end

  create_table "investigations", force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notes", force: :cascade do |t|
    t.integer "investigation_id"
    t.string "body_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "authentication_token"
    t.datetime "authentication_token_created_at"
    t.datetime "datetime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "works", force: :cascade do |t|
    t.string "doi"
    t.string "title"
    t.string "openalex_id"
    t.string "language"
    t.string "publication_year"
    t.string "keywords", default: [], array: true
    t.string "topics", default: [], array: true
    t.boolean "is_open_access", default: false
    t.string "open_access_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "author_works", "authors"
  add_foreign_key "author_works", "works"
  add_foreign_key "investigation_authors", "authors"
  add_foreign_key "investigation_authors", "investigations"
  add_foreign_key "investigation_works", "investigations"
  add_foreign_key "investigation_works", "works"
end
