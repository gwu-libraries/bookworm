class AddOpenAlexIdToTopics < ActiveRecord::Migration[7.1]
  def change
    add_column :topics, :openalex_id, :string
    add_index :topics, :openalex_id
  end
end
