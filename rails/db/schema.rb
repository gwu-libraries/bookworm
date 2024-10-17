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

ActiveRecord::Schema[7.1].define(version: 2024_10_03_155628) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string "orcid"
    t.string "display_name"
    t.jsonb "display_name_alternatives"
    t.bigint "works_count"
    t.bigint "cited_by_count"
    t.string "last_known_institution"
    t.string "works_api_url"
    t.string "openalex_id"
    t.index ["openalex_id"], name: "index_authors_on_openalex_id"
  end

  create_table "authors_counts_by_years", force: :cascade do |t|
    t.bigint "author_id", null: false
    t.bigint "year", null: false
    t.bigint "works_count"
    t.bigint "cited_by_count"
    t.bigint "oa_works_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_authors_counts_by_years_on_author_id"
  end

  create_table "authors_ids", force: :cascade do |t|
    t.bigint "author_id", null: false
    t.string "openalex"
    t.string "orcid"
    t.string "scopus"
    t.string "twitter"
    t.string "wikipedia"
    t.bigint "mag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_authors_ids_on_author_id"
  end

  create_table "concepts", force: :cascade do |t|
    t.string "wikidata"
    t.string "display_name"
    t.bigint "level"
    t.string "description"
    t.bigint "works_count"
    t.bigint "cited_by_count"
    t.string "image_url"
    t.string "image_thumbnail_url"
    t.string "works_api_url"
  end

  create_table "concepts_ancestors", force: :cascade do |t|
    t.string "concept_id", null: false
    t.string "ancestor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "concepts_counts_by_years", force: :cascade do |t|
    t.bigint "concept_id", null: false
    t.bigint "year", null: false
    t.bigint "works_count"
    t.bigint "cited_by_count"
    t.bigint "oa_works_count"
    t.index ["concept_id"], name: "index_concepts_counts_by_years_on_concept_id"
  end

  create_table "concepts_ids", force: :cascade do |t|
    t.bigint "concept_id", null: false
    t.string "openalex"
    t.string "wikidata"
    t.string "wikipedia"
    t.jsonb "umls_aui"
    t.jsonb "umls_cui"
    t.bigint "mag"
    t.index ["concept_id"], name: "index_concepts_ids_on_concept_id"
  end

  create_table "concepts_related_concepts", force: :cascade do |t|
    t.string "concept_id"
    t.string "related_concept_id"
    t.float "score"
  end

  create_table "institutions", force: :cascade do |t|
    t.string "openalex_id"
    t.string "ror"
    t.string "display_name"
    t.string "country_code"
    t.string "institution_type"
    t.string "homepage_url"
    t.string "image_url"
    t.string "image_thumbnail_url"
    t.jsonb "display_name_acronyms"
    t.jsonb "display_name_alternatives"
    t.bigint "works_count"
    t.bigint "cited_by_count"
    t.string "works_api_url"
  end

  create_table "institutions_associated_institutions", force: :cascade do |t|
    t.integer "institution_id"
    t.integer "associated_institution_id"
    t.string "relationship"
  end

  create_table "institutions_counts_by_years", force: :cascade do |t|
    t.bigint "institution_id", null: false
    t.bigint "year"
    t.bigint "works_count"
    t.bigint "cited_by_count"
    t.bigint "oa_works_count"
    t.index ["institution_id"], name: "index_institutions_counts_by_years_on_institution_id"
  end

  create_table "institutions_geos", force: :cascade do |t|
    t.bigint "institution_id", null: false
    t.string "city"
    t.string "geonames_city_id"
    t.string "region"
    t.string "country_code"
    t.string "country"
    t.float "latitude"
    t.float "longitude"
    t.index ["institution_id"], name: "index_institutions_geos_on_institution_id"
  end

  create_table "institutions_ids", force: :cascade do |t|
    t.bigint "institution_id", null: false
    t.string "openalex"
    t.string "ror"
    t.string "grid"
    t.string "wikipedia"
    t.string "wikidata"
    t.bigint "mag"
    t.index ["institution_id"], name: "index_institutions_ids_on_institution_id"
  end

  create_table "publishers", force: :cascade do |t|
    t.string "display_name"
    t.jsonb "alternate_titles"
    t.jsonb "country_codes"
    t.bigint "hierarchy_level"
    t.string "parent_publisher"
    t.bigint "works_count"
    t.bigint "cited_by_count"
    t.string "sources_api_url"
    t.string "openalex_id"
    t.index ["openalex_id"], name: "index_publishers_on_openalex_id"
  end

  create_table "publishers_counts_by_years", force: :cascade do |t|
    t.bigint "publisher_id", null: false
    t.bigint "year"
    t.bigint "works_count"
    t.bigint "cited_by_count"
    t.bigint "oa_works_count"
    t.index ["publisher_id"], name: "index_publishers_counts_by_years_on_publisher_id"
  end

  create_table "publishers_ids", force: :cascade do |t|
    t.bigint "publisher_id", null: false
    t.string "openalex"
    t.string "ror"
    t.string "wikidata"
    t.index ["publisher_id"], name: "index_publishers_ids_on_publisher_id"
  end

  create_table "sources", force: :cascade do |t|
    t.string "issn_l"
    t.jsonb "issn"
    t.string "display_name"
    t.string "publisher"
    t.bigint "works_count"
    t.bigint "cited_by_count"
    t.boolean "is_oa"
    t.boolean "is_in_doaj"
    t.string "homepage_url"
    t.string "works_api_url"
  end

  create_table "sources_counts_by_years", force: :cascade do |t|
    t.bigint "source_id", null: false
    t.bigint "year"
    t.bigint "works_count"
    t.bigint "cited_by_count"
    t.bigint "oa_works_count"
    t.index ["source_id"], name: "index_sources_counts_by_years_on_source_id"
  end

  create_table "sources_ids", force: :cascade do |t|
    t.bigint "source_id", null: false
    t.string "openalex"
    t.string "issn_l"
    t.jsonb "issn"
    t.bigint "mag"
    t.string "wikidata"
    t.string "fatcat"
    t.index ["source_id"], name: "index_sources_ids_on_source_id"
  end

  create_table "topics", force: :cascade do |t|
    t.string "display_name"
    t.string "subfield_id"
    t.string "subfield_display_name"
    t.string "field_id"
    t.string "field_display_name"
    t.string "domain_id"
    t.string "domain_display_name"
    t.string "description"
    t.string "keywords", default: [], array: true
    t.string "works_api_url"
    t.string "wikipedia_id"
    t.bigint "works_count"
    t.bigint "cited_by_count"
    t.string "openalex_id"
    t.index ["openalex_id"], name: "index_topics_on_openalex_id"
  end

  create_table "works", force: :cascade do |t|
    t.string "doi"
    t.string "title"
    t.string "display_name"
    t.bigint "publication_year"
    t.string "publication_date"
    t.string "type"
    t.bigint "cited_by_count"
    t.boolean "is_retracted"
    t.boolean "is_paratext"
    t.string "cited_by_api_url"
    t.jsonb "abstract_inverted_index"
    t.string "language"
  end

  create_table "works_authorships", force: :cascade do |t|
    t.bigint "work_id", null: false
    t.bigint "author_id", null: false
    t.bigint "institution_id", null: false
    t.string "author_position"
    t.string "raw_affiliation_string"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_works_authorships_on_author_id"
    t.index ["institution_id"], name: "index_works_authorships_on_institution_id"
    t.index ["work_id"], name: "index_works_authorships_on_work_id"
  end

  create_table "works_best_oa_locations", force: :cascade do |t|
    t.bigint "work_id", null: false
    t.bigint "source_id", null: false
    t.string "landing_page_url"
    t.string "pdf_url"
    t.boolean "is_oa"
    t.string "version"
    t.string "license"
    t.index ["source_id"], name: "index_works_best_oa_locations_on_source_id"
    t.index ["work_id"], name: "index_works_best_oa_locations_on_work_id"
  end

  create_table "works_biblios", force: :cascade do |t|
    t.bigint "work_id", null: false
    t.string "volume"
    t.string "issue"
    t.string "first_page"
    t.string "last_page"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["work_id"], name: "index_works_biblios_on_work_id"
  end

  create_table "works_concepts", force: :cascade do |t|
    t.bigint "work_id", null: false
    t.bigint "concept_id", null: false
    t.float "score"
    t.index ["concept_id"], name: "index_works_concepts_on_concept_id"
    t.index ["work_id"], name: "index_works_concepts_on_work_id"
  end

  create_table "works_ids", force: :cascade do |t|
    t.bigint "work_id", null: false
    t.string "openalex"
    t.string "doi"
    t.bigint "mag"
    t.string "pmid"
    t.string "pmcid"
    t.index ["work_id"], name: "index_works_ids_on_work_id"
  end

  create_table "works_locations", force: :cascade do |t|
    t.bigint "work_id", null: false
    t.bigint "source_id", null: false
    t.string "landing_page_url"
    t.string "pdf_url"
    t.boolean "is_oa"
    t.string "version"
    t.string "license"
    t.index ["source_id"], name: "index_works_locations_on_source_id"
    t.index ["work_id"], name: "index_works_locations_on_work_id"
  end

  create_table "works_meshes", force: :cascade do |t|
    t.bigint "work_id", null: false
    t.string "descriptor_ui"
    t.string "descriptor_name"
    t.string "qualifier_ui"
    t.string "qualifier_name"
    t.boolean "is_major_topic"
    t.index ["work_id"], name: "index_works_meshes_on_work_id"
  end

  create_table "works_open_accesses", force: :cascade do |t|
    t.bigint "work_id", null: false
    t.boolean "is_oa"
    t.string "oa_status"
    t.string "oa_url"
    t.boolean "any_repository_has_fulltext"
    t.index ["work_id"], name: "index_works_open_accesses_on_work_id"
  end

  create_table "works_primary_locations", force: :cascade do |t|
    t.bigint "work_id", null: false
    t.bigint "source_id", null: false
    t.string "landing_page_url"
    t.string "pdf_url"
    t.boolean "is_oa"
    t.string "version"
    t.string "license"
    t.index ["source_id"], name: "index_works_primary_locations_on_source_id"
    t.index ["work_id"], name: "index_works_primary_locations_on_work_id"
  end

  create_table "works_referenced_works", force: :cascade do |t|
    t.string "work_id"
    t.string "referenced_work_id"
  end

  create_table "works_related_works", force: :cascade do |t|
    t.string "work_id"
    t.string "related_work_id"
  end

  create_table "works_topics", force: :cascade do |t|
    t.bigint "work_id", null: false
    t.bigint "topic_id", null: false
    t.float "score"
    t.index ["topic_id"], name: "index_works_topics_on_topic_id"
    t.index ["work_id"], name: "index_works_topics_on_work_id"
  end

  add_foreign_key "authors_counts_by_years", "authors"
  add_foreign_key "authors_ids", "authors"
  add_foreign_key "concepts_counts_by_years", "concepts"
  add_foreign_key "concepts_ids", "concepts"
  add_foreign_key "institutions_counts_by_years", "institutions"
  add_foreign_key "institutions_geos", "institutions"
  add_foreign_key "institutions_ids", "institutions"
  add_foreign_key "publishers_counts_by_years", "publishers"
  add_foreign_key "publishers_ids", "publishers"
  add_foreign_key "sources_counts_by_years", "sources"
  add_foreign_key "sources_ids", "sources"
  add_foreign_key "works_authorships", "authors"
  add_foreign_key "works_authorships", "institutions"
  add_foreign_key "works_authorships", "works"
  add_foreign_key "works_best_oa_locations", "sources"
  add_foreign_key "works_best_oa_locations", "works"
  add_foreign_key "works_biblios", "works"
  add_foreign_key "works_concepts", "concepts"
  add_foreign_key "works_concepts", "works"
  add_foreign_key "works_ids", "works"
  add_foreign_key "works_locations", "sources"
  add_foreign_key "works_locations", "works"
  add_foreign_key "works_meshes", "works"
  add_foreign_key "works_open_accesses", "works"
  add_foreign_key "works_primary_locations", "sources"
  add_foreign_key "works_primary_locations", "works"
  add_foreign_key "works_topics", "topics"
  add_foreign_key "works_topics", "works"
end
