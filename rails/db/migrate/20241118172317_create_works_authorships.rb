class CreateWorksAuthorships < ActiveRecord::Migration[7.1]
  def change
    create_table :works_authorships do |t|
      t.string :work_openalex_id
      t.string :author_position
      t.string :author_openalex_id
      t.string :institution_openalex_id
      t.string :raw_affiliation_string

      t.timestamps
    end

    add_index :works_authorships, :work_openalex_id
    add_index :works_authorships, :author_openalex_id
    add_index :works_authorships, :institution_openalex_id
  end
end
