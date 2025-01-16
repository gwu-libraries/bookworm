class CreateSourcesIds < ActiveRecord::Migration[7.1]
  def change
    create_table :sources_ids do |t|
      t.string :source_openalex_id
      t.jsonb :issn_l
      t.string :issn
      t.string :mag
      t.string :wikidata
      t.string :fatcat

      t.timestamps
    end

    add_index :sources_ids, :source_openalex_id
  end
end
