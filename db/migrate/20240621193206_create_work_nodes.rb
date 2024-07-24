class CreateWorkNodes < ActiveRecord::Migration[7.1]
  def change
    create_table :work_nodes do |t|
      t.integer :x_coordinate
      t.integer :y_coordinate

      t.references :investigation, null: false, foreign_key: true
      t.references :work, null: false, foreign_key: true

      t.boolean :visible, null: false, default: true

      t.timestamps
    end
  end
end
