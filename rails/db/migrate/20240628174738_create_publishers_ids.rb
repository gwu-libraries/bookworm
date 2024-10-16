class CreatePublishersIds < ActiveRecord::Migration[7.1]
  def change
    create_table :publishers_ids do |t|
      t.references :publisher, null: false, foreign_key: true
      t.string :openalex
      t.string :ror
      t.string :wikidata
    end
  end
end
