class CreatePublishersIds < ActiveRecord::Migration[7.1]
  def change
    create_table :publishers_ids do |t|
      t.string :publisher_openalex_id
      t.string :ror
      t.string :wikidata

      t.timestamps
    end

    add_index :publishers_ids, :publisher_openalex_id
  end
end
