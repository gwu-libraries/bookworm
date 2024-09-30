class CreateVenuesIds < ActiveRecord::Migration[7.1]
  def change
    create_table :venues_ids do |t|
      t.references :venue, null: false, foreign_key: true
      t.string :openalex
      t.string :issn_l
      t.string :issn
      t.integer :mag
      
    end
  end
end
