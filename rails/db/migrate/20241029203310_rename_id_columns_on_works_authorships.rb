class RenameIdColumnsOnWorksAuthorships < ActiveRecord::Migration[7.1]
  def change
    rename_column :works_authorships, :work_id, :work_openalex_id
    rename_column :works_authorships, :author_id, :author_openalex_id
    rename_column :works_authorships, :institution_id, :institution_openalex_id
  end
end
