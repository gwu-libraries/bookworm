class AddOpenalexIdIndexingToAuthors < ActiveRecord::Migration[7.1]
  def change
    add_index :authors, :openalex_id
  end
end
