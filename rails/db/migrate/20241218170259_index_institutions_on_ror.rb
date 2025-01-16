class IndexInstitutionsOnRor < ActiveRecord::Migration[7.1]
  def change
    add_index :institutions, :ror
  end
end
