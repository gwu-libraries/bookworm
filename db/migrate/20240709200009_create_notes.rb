class CreateNotes < ActiveRecord::Migration[7.1]
  def change
    create_table :notes do |t|
      t.integer :x_coordinate
      t.integer :y_coordinate
      t.integer :investigation_id
      t.string :body_text

      t.timestamps
    end
  end
end
