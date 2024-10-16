class CreateWorksReferencedWorks < ActiveRecord::Migration[7.1]
  def change
    create_table :works_referenced_works do |t|
      t.string :work_id
      t.string :referenced_work_id

      # self-referential many-to-many
    end
  end
end
