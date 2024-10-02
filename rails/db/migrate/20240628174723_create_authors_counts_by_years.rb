class CreateAuthorsCountsByYears < ActiveRecord::Migration[7.1]
  def change
    create_table :authors_counts_by_years do |t|
      t.references :author, null: false, foreign_key: true
      t.bigint :year, null: false
      t.bigint :works_count
      t.bigint :cited_by_count
      t.bigint :oa_works_count 

      t.timestamps
    end
  end
end
