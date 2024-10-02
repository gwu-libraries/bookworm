class CreateConceptsCountsByYears < ActiveRecord::Migration[7.1]
  def change
    create_table :concepts_counts_by_years do |t|
      t.references :concept, null: false, foreign_key: true
      t.bigint :year, null: false
      t.bigint :works_count
      t.bigint :cited_by_count
      t.bigint :oa_works_count
    end
  end
end
