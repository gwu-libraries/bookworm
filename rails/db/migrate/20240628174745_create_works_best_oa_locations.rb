# frozen_string_literal: true

class CreateWorksBestOaLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :works_best_oa_locations do |t|
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
