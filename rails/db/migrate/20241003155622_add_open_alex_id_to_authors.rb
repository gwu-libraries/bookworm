class AddOpenAlexIdToAuthors < ActiveRecord::Migration[7.1]
  def change
    add_column :authors, :openalex_id, :integer
  end
end
