class RemoveTimestampsFromWorksReferencedWorks < ActiveRecord::Migration[7.1]
  def change
    remove_column :works_referenced_works, :created_at, :string
    remove_column :works_referenced_works, :updated_at, :string
  end
end
