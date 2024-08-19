class CreateAuthors < ActiveRecord::Migration[7.1]
  def change
    create_table :authors do |t|
      t.string :name
      t.string :orcid
      t.string :openalex_id
      t.integer :h_index
      t.integer :i10_index
      t.integer :cited_by_count
      t.integer :works_count

      t.timestamps
    end
  end
end
