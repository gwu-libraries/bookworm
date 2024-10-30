class IndexInsitutionsOnOpenalexId < ActiveRecord::Migration[7.1]
  def change
    add_index :institutions, :openalex_id
  end
end
