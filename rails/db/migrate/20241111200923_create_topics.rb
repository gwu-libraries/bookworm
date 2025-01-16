class CreateTopics < ActiveRecord::Migration[7.1]
  def change
    create_table :topics do |t|
      t.string :topic_openalex_id
      t.string :display_name
      t.integer :openalex_subfield_id
      t.string :openalex_subfield_display_name
      t.integer :openalex_field_id
      t.string :openalex_field_display_name
      t.integer :openalex_domain_id
      t.string :openalex_domain_display_name
      t.string :description
      t.string :keywords, array: true, default: []
      t.string :works_api_url
      t.string :wikipedia_id
      t.integer :works_count
      t.integer :cited_by_count

      t.timestamps
    end

    add_index :topics, :topic_openalex_id
    add_index :topics, :openalex_subfield_id
    add_index :topics, :openalex_field_id
    add_index :topics, :openalex_domain_id
  end
end
