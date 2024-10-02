class CreateSources < ActiveRecord::Migration[7.1]
  def change
    create_table :sources do |t|
      t.string :issn_l
      t.jsonb :issn
      t.string :display_name
      t.string :publisher
      t.bigint :works_count
      t.bigint :cited_by_count
      t.boolean :is_oa
      t.boolean :is_in_doaj
      t.string :homepage_url
      t.string :works_api_url
      
    end
  end
end
