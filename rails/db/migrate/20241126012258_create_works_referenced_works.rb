class CreateWorksReferencedWorks < ActiveRecord::Migration[7.1]
  def change
    create_table :works_referenced_works do |t|
      t.string :work_openalex_id
      t.string :referenced_work_openalex_id

      t.timestamps
    end

    add_index :works_referenced_works, :work_openalex_id
    add_index :works_referenced_works, :referenced_work_openalex_id
  end
end
