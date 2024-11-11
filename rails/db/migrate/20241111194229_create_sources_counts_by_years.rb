class CreateSourcesCountsByYears < ActiveRecord::Migration[7.1]
  def change
    create_table :sources_counts_by_years do |t|
      t.string :source_openalex_id
      t.integer :year
      t.integer :works_count
      t.integer :cited_by_count
      t.integer :oa_works_count

      t.timestamps
    end

    add_index :sources_counts_by_years, :source_openalex_id
  end
end
