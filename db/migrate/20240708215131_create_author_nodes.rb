class CreateAuthorNodes < ActiveRecord::Migration[7.1]
  def change
    create_table :author_nodes do |t|
      t.integer :x_coordinate
      t.integer :y_coordinate
      t.boolean :visible, null: false, default: true

      t.references :investigation, null: false, foreign_key: true
      t.references :author, null: false, foreign_key: true

      t.timestamps
    end
  end
end
