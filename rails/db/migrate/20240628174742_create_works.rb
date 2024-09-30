# frozen_string_literal: true

class CreateWorks < ActiveRecord::Migration[7.1]
  def change
    create_table :works do |t|
      t.string :doi
      t.string :title
      t.string :display_name
      t.integer :publication_year
      t.string :publication_date
      t.string :type
      t.integer :cited_by_count
      t.boolean :is_retracted
      t.boolean :is_paratext
      t.string :cited_by_api_url
      t.jsonb :abstract_inverted_index
      t.string :language

    end
  end
end
