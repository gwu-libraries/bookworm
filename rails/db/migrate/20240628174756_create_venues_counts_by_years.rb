class CreateVenuesCountsByYears < ActiveRecord::Migration[7.1]
  def change
    create_table :venues_counts_by_years do |t|
      t.references :venue, null: false, foreign_key: true
      t.integer :year
      t.integer :works_count
      t.integer :cited_by_count
      
    end
  end
end
