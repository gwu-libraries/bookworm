class DropAndRemakeWorksAuthorshipTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :works_authorships

    create_table :works_authorships do |t|
      t.string :author_position
      t.string :work_openalex_id
      t.string :author_openalex_id
      t.string :institution_openalex_id
      t.string :raw_affiliation_string

      t.timestamps
    end
  end
end
