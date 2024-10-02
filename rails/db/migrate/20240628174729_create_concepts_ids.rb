class CreateConceptsIds < ActiveRecord::Migration[7.1]
  def change
    create_table :concepts_ids do |t|
      t.references :concept, null: false, foreign_key: true
      t.string :openalex
      t.string :wikidata
      t.string :wikipedia
      t.jsonb :umls_aui
      t.jsonb :umls_cui
      t.bigint :mag
    end
  end
end
