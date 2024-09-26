class CreateAuthors < ActiveRecord::Migration[7.1]
  def change
    create_table :authors do |t|
      t.string :orcid
      t.string :display_name
      t.jsonb :display_name_alternatives
      t.integer :works_count
      t.integer :cited_by_count
      t.string :last_known_institution
      t.string :works_api_url 

      t.timestamps
    end
  end
end
