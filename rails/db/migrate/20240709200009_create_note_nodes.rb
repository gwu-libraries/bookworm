class CreateNoteNodes < ActiveRecord::Migration[7.1]
  def change
    create_table :note_nodes do |t|
      t.integer :x_coordinate
      t.integer :y_coordinate
      t.boolean :visible

      t.integer :investigation_id
      t.string :body_text

      t.timestamps
    end
  end
end
