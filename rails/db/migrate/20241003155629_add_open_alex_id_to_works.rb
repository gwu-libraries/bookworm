class AddOpenAlexIdToWorks < ActiveRecord::Migration[7.1]
  def change
    add_column :works, :openalex_id, :string
    add_index :works, :openalex_id
  end
end
