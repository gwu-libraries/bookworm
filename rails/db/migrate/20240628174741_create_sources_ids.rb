class CreateSourcesIds < ActiveRecord::Migration[7.1]
  def change
    create_table :sources_ids do |t|
      t.references :source, null: false, foreign_key: true
      t.string :openalex
      t.string :issn_l
      t.jsonb :issn
      t.integer :mag
      t.string :wikidata
      t.string :fatcat
      
    end
  end
end
