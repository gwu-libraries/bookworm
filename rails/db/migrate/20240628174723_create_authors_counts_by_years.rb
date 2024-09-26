class CreateAuthorsCountsByYears < ActiveRecord::Migration[7.1]
  def change
    create_table :authors_counts_by_years do |t|
      t.references :author, null: false, foreign_key: true
      t.integer :year, null: false
      t.integer :works_count
      t.integer :cited_by_count
      t.integer :oa_works_count 

      t.timestamps
    end
  end
end
