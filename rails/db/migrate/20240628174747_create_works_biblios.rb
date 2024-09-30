class CreateWorksBiblios < ActiveRecord::Migration[7.1]
  def change
    create_table :works_biblios do |t|
      t.references :work, null: false, foreign_key: true
      t.string :volume
      t.string :issue
      t.string :first_page
      t.string :last_page

      t.timestamps
    end
  end
end
