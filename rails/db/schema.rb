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

ActiveRecord::Schema[7.1].define(version: 2024_12_18_170259) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string "author_openalex_id"
    t.string "orcid"
    t.string "display_name"
    t.jsonb "display_name_alternatives"
    t.bigint "works_count"
    t.bigint "cited_by_count"
    t.string "last_known_institution"
    t.string "works_api_url"
    t.index ["author_openalex_id"], name: "index_authors_on_author_openalex_id"
    t.index ["orcid"], name: "index_authors_on_orcid"
  end

  create_table "authors_counts_by_years", force: :cascade do |t|
    t.string "author_openalex_id"
    t.integer "year"
    t.integer "works_count"
    t.integer "cited_by_count"
    t.integer "oa_works_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_openalex_id"], name: "index_authors_counts_by_years_on_author_openalex_id"
  end

  create_table "authors_ids", force: :cascade do |t|
    t.string "author_openalex_id"
    t.string "orcid"
    t.string "scopus"
    t.string "twitter"
    t.string "wikipedia"
    t.string "mag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_openalex_id"], name: "index_authors_ids_on_author_openalex_id"
  end

  create_table "institutions", force: :cascade do |t|
    t.string "institution_openalex_id"
    t.string "ror"
    t.string "display_name"
    t.string "country_code"
    t.string "institution_type"
    t.string "homepage_url"
    t.string "image_url"
    t.string "image_thumbnail_url"
    t.jsonb "display_name_acronyms"
    t.jsonb "display_name_alternatives"
    t.integer "works_count"
    t.integer "cited_by_count"
    t.string "works_api_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["institution_openalex_id"], name: "index_institutions_on_institution_openalex_id"
    t.index ["ror"], name: "index_institutions_on_ror"
  end

  create_table "institutions_associated_institutions", force: :cascade do |t|
    t.string "institution_openalex_id"
    t.string "associated_institution_openalex_id"
    t.string "relationship"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["associated_institution_openalex_id"], name: "idx_on_associated_institution_openalex_id_0b6f4e76cc"
    t.index ["institution_openalex_id"], name: "idx_on_institution_openalex_id_2cfe9cc51b"
  end

  create_table "institutions_counts_by_years", force: :cascade do |t|
    t.string "institution_openalex_id"
    t.integer "year"
    t.integer "works_count"
    t.integer "cited_by_count"
    t.integer "oa_works_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["institution_openalex_id"], name: "index_institutions_counts_by_years_on_institution_openalex_id"
  end

  create_table "institutions_geos", force: :cascade do |t|
    t.string "institution_openalex_id"
    t.string "city"
    t.integer "geonames_city_id"
    t.string "region"
    t.string "country_code"
    t.string "country"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["institution_openalex_id"], name: "index_institutions_geos_on_institution_openalex_id"
  end

  create_table "institutions_ids", force: :cascade do |t|
    t.string "institution_openalex_id"
    t.string "ror"
    t.string "grid"
    t.string "wikipedia"
    t.string "wikidata"
    t.string "mag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["institution_openalex_id"], name: "index_institutions_ids_on_institution_openalex_id"
  end

  create_table "publishers", force: :cascade do |t|
    t.string "publisher_openalex_id"
    t.string "display_name"
    t.jsonb "alternate_titles"
    t.jsonb "country_codes"
    t.integer "hierarchy_level"
    t.string "parent_publisher"
    t.integer "works_count"
    t.integer "cited_by_count"
    t.string "sources_api_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["publisher_openalex_id"], name: "index_publishers_on_publisher_openalex_id"
  end

  create_table "publishers_counts_by_years", force: :cascade do |t|
    t.string "publisher_openalex_id"
    t.integer "year"
    t.integer "works_count"
    t.integer "cited_by_count"
    t.integer "oa_works_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["publisher_openalex_id"], name: "index_publishers_counts_by_years_on_publisher_openalex_id"
  end

  create_table "publishers_ids", force: :cascade do |t|
    t.string "publisher_openalex_id"
    t.string "ror"
    t.string "wikidata"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["publisher_openalex_id"], name: "index_publishers_ids_on_publisher_openalex_id"
  end

  create_table "sources", force: :cascade do |t|
    t.string "source_openalex_id"
    t.string "issn_l"
    t.jsonb "issn"
    t.string "display_name"
    t.string "publisher"
    t.integer "works_count"
    t.integer "cited_by_count"
    t.boolean "is_oa"
    t.boolean "is_in_doaj"
    t.string "homepage_url"
    t.string "works_api_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["source_openalex_id"], name: "index_sources_on_source_openalex_id"
  end

  create_table "sources_counts_by_years", force: :cascade do |t|
    t.string "source_openalex_id"
    t.integer "year"
    t.integer "works_count"
    t.integer "cited_by_count"
    t.integer "oa_works_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["source_openalex_id"], name: "index_sources_counts_by_years_on_source_openalex_id"
  end

  create_table "sources_ids", force: :cascade do |t|
    t.string "source_openalex_id"
    t.jsonb "issn_l"
    t.string "issn"
    t.string "mag"
    t.string "wikidata"
    t.string "fatcat"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["source_openalex_id"], name: "index_sources_ids_on_source_openalex_id"
  end

  create_table "topics", force: :cascade do |t|
    t.string "topic_openalex_id"
    t.string "display_name"
    t.integer "openalex_subfield_id"
    t.string "openalex_subfield_display_name"
    t.integer "openalex_field_id"
    t.string "openalex_field_display_name"
    t.integer "openalex_domain_id"
    t.string "openalex_domain_display_name"
    t.string "description"
    t.string "keywords", default: [], array: true
    t.string "works_api_url"
    t.string "wikipedia_id"
    t.integer "works_count"
    t.integer "cited_by_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["openalex_domain_id"], name: "index_topics_on_openalex_domain_id"
    t.index ["openalex_field_id"], name: "index_topics_on_openalex_field_id"
    t.index ["openalex_subfield_id"], name: "index_topics_on_openalex_subfield_id"
    t.index ["topic_openalex_id"], name: "index_topics_on_topic_openalex_id"
  end

  create_table "works", force: :cascade do |t|
    t.string "work_openalex_id"
    t.string "doi"
    t.string "title"
    t.string "display_name"
    t.integer "publication_year"
    t.string "publication_date"
    t.string "work_type"
    t.integer "cited_by_count"
    t.boolean "is_retracted"
    t.boolean "is_paratext"
    t.string "cited_by_api_url"
    t.jsonb "abstract_inverted_index"
    t.string "language"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doi"], name: "index_works_on_doi"
    t.index ["work_openalex_id"], name: "index_works_on_work_openalex_id"
  end

  create_table "works_authorships", force: :cascade do |t|
    t.string "work_openalex_id"
    t.string "author_position"
    t.string "author_openalex_id"
    t.string "institution_openalex_id"
    t.string "raw_affiliation_string"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_openalex_id"], name: "index_works_authorships_on_author_openalex_id"
    t.index ["institution_openalex_id"], name: "index_works_authorships_on_institution_openalex_id"
    t.index ["work_openalex_id"], name: "index_works_authorships_on_work_openalex_id"
  end

  create_table "works_best_oa_locations", force: :cascade do |t|
    t.string "work_openalex_id"
    t.string "source_openalex_id"
    t.string "landing_page_url"
    t.string "pdf_url"
    t.boolean "is_oa"
    t.string "version"
    t.string "license"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["source_openalex_id"], name: "index_works_best_oa_locations_on_source_openalex_id"
    t.index ["work_openalex_id"], name: "index_works_best_oa_locations_on_work_openalex_id"
  end

  create_table "works_biblios", force: :cascade do |t|
    t.string "work_openalex_id"
    t.string "volume"
    t.string "issue"
    t.string "first_page"
    t.string "last_page"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["work_openalex_id"], name: "index_works_biblios_on_work_openalex_id"
  end

  create_table "works_ids", force: :cascade do |t|
    t.string "work_openalex_id"
    t.string "doi"
    t.string "mag"
    t.string "pmid"
    t.string "pmcid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doi"], name: "index_works_ids_on_doi"
    t.index ["work_openalex_id"], name: "index_works_ids_on_work_openalex_id"
  end

  create_table "works_locations", force: :cascade do |t|
    t.string "work_openalex_id"
    t.string "source_openalex_id"
    t.string "landing_page_url"
    t.string "pdf_url"
    t.boolean "is_oa"
    t.string "version"
    t.string "license"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["source_openalex_id"], name: "index_works_locations_on_source_openalex_id"
    t.index ["work_openalex_id"], name: "index_works_locations_on_work_openalex_id"
  end

  create_table "works_open_accesses", force: :cascade do |t|
    t.string "work_openalex_id"
    t.boolean "is_oa"
    t.string "oa_status"
    t.string "oa_url"
    t.boolean "any_repository_has_fulltext"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["work_openalex_id"], name: "index_works_open_accesses_on_work_openalex_id"
  end

  create_table "works_primary_locations", force: :cascade do |t|
    t.string "work_openalex_id"
    t.string "source_openalex_id"
    t.string "landing_page_url"
    t.string "pdf_url"
    t.boolean "is_oa"
    t.string "version"
    t.string "license"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["source_openalex_id"], name: "index_works_primary_locations_on_source_openalex_id"
    t.index ["work_openalex_id"], name: "index_works_primary_locations_on_work_openalex_id"
  end

  create_table "works_referenced_works", force: :cascade do |t|
    t.string "work_openalex_id"
    t.string "referenced_work_openalex_id"
    t.index ["referenced_work_openalex_id"], name: "index_works_referenced_works_on_referenced_work_openalex_id"
    t.index ["work_openalex_id"], name: "index_works_referenced_works_on_work_openalex_id"
  end

end
