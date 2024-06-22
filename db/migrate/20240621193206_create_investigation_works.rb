class CreateInvestigationWorks < ActiveRecord::Migration[7.1]
  def change
    create_table :investigation_works do |t|
      t.references :investigation, null: false, foreign_key: true
      t.references :work, null: false, foreign_key: true

      t.timestamps
    end
  end
end
