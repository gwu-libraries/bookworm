# frozen_string_literal: true

class CreateWorks < ActiveRecord::Migration[7.1]
  def change
    create_table :works do |t|
      t.string :doi
      t.string :title
      t.string :openalex_id
      t.string :language
      t.string :publication_year
      t.string :keywords, array: true, default: []
      t.string :topics, array: true, default: []
      t.boolean :is_open_access, default: false
      t.string :open_access_url

      t.timestamps
    end
  end
end
