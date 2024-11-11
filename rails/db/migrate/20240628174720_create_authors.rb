class CreateAuthors < ActiveRecord::Migration[7.1]
  def change
    create_table :authors do |t|
      t.string :author_openalex_id
      t.string :orcid
      t.string :display_name
      t.jsonb :display_name_alternatives
      t.bigint :works_count
      t.bigint :cited_by_count
      t.string :last_known_institution
      t.string :works_api_url
    end

    add_index :authors, :author_openalex_id
  end
end
