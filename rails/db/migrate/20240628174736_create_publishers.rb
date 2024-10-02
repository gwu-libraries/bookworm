class CreatePublishers < ActiveRecord::Migration[7.1]
  def change
    create_table :publishers do |t|
      t.string :display_name
      t.jsonb :alternate_titles
      t.jsonb :country_codes
      t.bigint :hierarchy_level
      t.string :parent_publisher
      t.bigint :works_count
      t.bigint :cited_by_count
      t.string :sources_api_url
      
    end
  end
end
