class CreateAuthorWorks < ActiveRecord::Migration[7.1]
  def change
    create_table :author_works do |t|
      t.references :author, null: false, foreign_key: true
      t.references :work, null: false, foreign_key: true

      t.timestamps
    end
  end
end
