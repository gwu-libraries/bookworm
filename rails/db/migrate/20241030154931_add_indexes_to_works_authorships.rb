class AddIndexesToWorksAuthorships < ActiveRecord::Migration[7.1]
  def change
    add_index :works_authorships, :author_openalex_id
    add_index :works_authorships, :work_openalex_id
    add_index :works_authorships, :institution_openalex_id
  end
end
