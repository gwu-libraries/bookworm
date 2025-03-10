class CreateSources < ActiveRecord::Migration[7.1]
  def change
    create_table :sources do |t|
      t.string :source_openalex_id
      t.string :issn_l
      t.jsonb :issn
      t.string :display_name
      t.string :publisher
      t.integer :works_count
      t.integer :cited_by_count
      t.boolean :is_oa
      t.boolean :is_in_doaj
      t.string :homepage_url
      t.string :works_api_url

      t.timestamps
    end

    add_index :sources, :source_openalex_id
  end
end
