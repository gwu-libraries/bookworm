class CreateWorksBiblios < ActiveRecord::Migration[7.1]
  def change
    create_table :works_biblios do |t|
      t.string :work_openalex_id
      t.string :volume
      t.string :issue
      t.string :first_page
      t.string :last_page

      t.timestamps
    end

    add_index :works_biblios, :work_openalex_id
  end
end
