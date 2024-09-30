class CreateConceptsCountsByYears < ActiveRecord::Migration[7.1]
  def change
    create_table :concepts_counts_by_years do |t|
      t.references :concept, null: false, foreign_key: true
      t.integer :year, null: false
      t.integer :works_count
      t.integer :cited_by_count
      t.integer :oa_works_count
    end
  end
end
