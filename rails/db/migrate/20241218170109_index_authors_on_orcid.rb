class IndexAuthorsOnOrcid < ActiveRecord::Migration[7.1]
  def change
    add_index :authors, :orcid
  end
end
