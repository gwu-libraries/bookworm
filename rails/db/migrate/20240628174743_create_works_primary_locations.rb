# frozen_string_literal: true

class CreateWorksPrimaryLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :works_primary_locations do |t|
      t.references :work, null: false, foreign_key: true
      t.references :source, null: false, foreign_key: true
      t.string :landing_page_url
      t.string :pdf_url
      t.boolean :is_oa
      t.string :version
      t.string :license
    end
  end
end
