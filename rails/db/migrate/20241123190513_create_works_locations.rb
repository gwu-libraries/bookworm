class CreateWorksLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :works_locations do |t|
      t.string :work_openalex_id
      t.string :source_openalex_id
      t.string :landing_page_url
      t.string :pdf_url
      t.boolean :is_oa
      t.string :version
      t.string :license

      t.timestamps
    end

    add_index :works_locations, :work_openalex_id
    add_index :works_locations, :source_openalex_id
  end
end
