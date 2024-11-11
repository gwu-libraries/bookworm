class CreateInstitutionsIds < ActiveRecord::Migration[7.1]
  def change
    create_table :institutions_ids do |t|
      t.string :institution_openalex_id
      t.string :ror
      t.string :grid
      t.string :wikipedia
      t.string :wikidata
      t.string :mag

      t.timestamps
    end

    add_index :institutions_ids, :institution_openalex_id
  end
end
