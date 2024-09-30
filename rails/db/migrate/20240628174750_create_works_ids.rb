class CreateWorksIds < ActiveRecord::Migration[7.1]
  def change
    create_table :works_ids do |t|
      t.references :work, null: false, foreign_key: true
      t.string :openalex
      t.string :doi
      t.integer :mag
      t.string :pmid
      t.string :pmcid

    end
  end
end
