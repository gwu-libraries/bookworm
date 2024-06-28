class CreateInvestigationWorks < ActiveRecord::Migration[7.1]
  def change
    create_table :investigation_works do |t|
      # t.integer :work_x_coordinate, null: false
      # t.integer :work_y_coordinate, null: false

      t.references :investigation, null: false, foreign_key: true
      t.references :work, null: false, foreign_key: true
      
      t.boolean :root_work, null: false, default: false

      t.timestamps
    end
  end
end
