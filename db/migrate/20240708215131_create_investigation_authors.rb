class CreateInvestigationAuthors < ActiveRecord::Migration[7.1]
  def change
    create_table :investigation_authors do |t|
      t.references :investigation, null: false, foreign_key: true
      t.references :author, null: false, foreign_key: true

      t.timestamps
    end
  end
end
