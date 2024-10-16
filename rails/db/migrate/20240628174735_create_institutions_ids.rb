class CreateInstitutionsIds < ActiveRecord::Migration[7.1]
  def change
    create_table :institutions_ids do |t|
      t.references :institution, null: false, foreign_key: true
      t.string :openalex
      t.string :ror
      t.string :grid
      t.string :wikipedia
      t.string :wikidata
      t.bigint :mag
    end
  end
end
