class CreateConcepts < ActiveRecord::Migration[7.1]
  def change
    create_table :concepts do |t|
      t.string :wikidata
      t.string :display_name
      t.integer :level
      t.string :description
      t.integer :works_count
      t.integer :cited_by_count
      t.string :image_url
      t.string :image_thumbnail_url
      t.string :works_api_url
      
    end
  end
end
