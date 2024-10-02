class CreatePublishersCountsByYears < ActiveRecord::Migration[7.1]
  def change
    create_table :publishers_counts_by_years do |t|
      t.references :publisher, null: false, foreign_key: true
      t.bigint :year
      t.bigint :works_count
      t.bigint :cited_by_count
      t.bigint :oa_works_count
      
    end
  end
end
