class CreateTopics < ActiveRecord::Migration[7.1]
  def change
    create_table :topics do |t|
      t.string :display_name
      t.string :subfield_id
      t.string :subfield_display_name
      t.string :field_id
      t.string :field_display_name
      t.string :domain_id
      t.string :domain_display_name
      t.string :description
      t.string :keywords
      t.string :works_api_url
      t.string :wikipedia_id
      t.integer :works_count
      t.integer :cited_by_count
      t.timestamps
    end
  end
end
