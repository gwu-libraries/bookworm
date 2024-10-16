class CreateInstitutions < ActiveRecord::Migration[7.1]
  def change
    create_table :institutions do |t|
      t.string :openalex_id
      t.string :ror
      t.string :display_name
      t.string :country_code
      t.string :institution_type
      t.string :homepage_url
      t.string :image_url
      t.string :image_thumbnail_url
      t.jsonb :display_name_acronyms
      t.jsonb :display_name_alternatives
      t.bigint :works_count
      t.bigint :cited_by_count
      t.string :works_api_url
    end
  end
end
