class CreateWorks < ActiveRecord::Migration[7.1]
  def change
    create_table :works do |t|
      t.string :work_openalex_id
      t.string :doi
      t.string :title
      t.string :display_name
      t.integer :publication_year
      t.string :publication_date
      t.string :work_type
      t.integer :cited_by_count
      t.boolean :is_retracted
      t.boolean :is_paratext
      t.string :cited_by_api_url
      t.jsonb :abstract_inverted_index
      t.string :language

      t.timestamps
    end

    add_index :works, :work_openalex_id
    add_index :works, :doi
  end
end
