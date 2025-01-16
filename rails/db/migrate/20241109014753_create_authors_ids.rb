class CreateAuthorsIds < ActiveRecord::Migration[7.1]
  def change
    create_table :authors_ids do |t|
      t.string :author_openalex_id
      t.string :orcid
      t.string :scopus
      t.string :twitter
      t.string :wikipedia
      t.string :mag

      t.timestamps
    end

    add_index :authors_ids, :author_openalex_id
  end
end
