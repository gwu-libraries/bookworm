class CreateAuthorshipEdges < ActiveRecord::Migration[7.1]
  def change
    create_table :authorship_edges do |t|
      t.references :investigation, null: false, foreign_key: true
      t.references :authorship_connection, null: false, foreign_key: true
      t.boolean :visible, null: false, default: true

      t.timestamps
    end
  end
end
