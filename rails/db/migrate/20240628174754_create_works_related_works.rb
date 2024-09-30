class CreateWorksRelatedWorks < ActiveRecord::Migration[7.1]
  def change
    create_table :works_related_works do |t|
      t.string :work_id
      t.string :related_work_id

      # self referential many-to-many
    end
  end
end
