class CreateInvestigationAuthors < ActiveRecord::Migration[7.1]
  def change
    create_table :investigation_authors do |t|
      t.integer :x_coordinate
      t.integer :y_coordinate
      t.references :investigation, null: false, foreign_key: true
      t.references :author, null: false, foreign_key: true
      t.boolean :visible, null: false, default: true

      t.timestamps
    end
  end
end
