class CreateWorksIds < ActiveRecord::Migration[7.1]
  def change
    create_table :works_ids do |t|
      t.string :work_openalex_id
      t.string :doi
      t.string :mag
      t.string :pmid
      t.string :pmcid

      t.timestamps
    end

    add_index :works_ids, :work_openalex_id
    add_index :works_ids, :doi
  end
end
