class CreateAuthorsIds < ActiveRecord::Migration[7.1]
  def change
    create_table :authors_ids do |t|
      t.references :author, null: false, foreign_key: true
      t.string :openalex
      t.string :orcid
      t.string :wikipedia
      t.integer :mag 

      t.timestamps
    end
  end
end
