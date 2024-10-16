class AddOpenalexIdIndexingToPublishers < ActiveRecord::Migration[7.1]
  def change
    add_index :publishers, :openalex_id
  end
end
