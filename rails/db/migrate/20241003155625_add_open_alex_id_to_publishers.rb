class AddOpenAlexIdToPublishers < ActiveRecord::Migration[7.1]
  def change
    add_column :publishers, :openalex_id, :integer
  end
end
