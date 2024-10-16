class CreateConcepts < ActiveRecord::Migration[7.1]
  def change
    create_table :concepts do |t|
      t.string :wikidata
      t.string :display_name
      t.bigint :level
      t.string :description
      t.bigint :works_count
      t.bigint :cited_by_count
      t.string :image_url
      t.string :image_thumbnail_url
      t.string :works_api_url
    end
  end
end
