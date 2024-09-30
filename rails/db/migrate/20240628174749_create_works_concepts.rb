class CreateWorksConcepts < ActiveRecord::Migration[7.1]
  def change
    create_table :works_concepts do |t|
      t.references :work, null: false, foreign_key: true
      t.references :concept, null: false, foreign_key: true
      
      t.float :score

    end
  end
end
