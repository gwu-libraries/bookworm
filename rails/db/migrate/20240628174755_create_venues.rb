class CreateVenues < ActiveRecord::Migration[7.1]
  def change
    create_table :venues do |t|
      t.string :issn_l
      t.string :issn
      t.string :display_name
      t.string :publisher
      t.integer :works_count
      t.integer :cited_by_count
      t.boolean :is_oa
      t.boolean :is_in_doaj
      t.string :homepage_url
      t.string :works_api_url
      
    end
  end
end
