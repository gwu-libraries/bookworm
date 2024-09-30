class CreateWorksAuthorships < ActiveRecord::Migration[7.1]
  def change
    create_table :works_authorships do |t|
      t.references :work, null: false, foreign_key: true
      t.references :author, null: false, foreign_key: true
      t.references :institution, null: false, foreign_key: true
      t.string :author_position
      t.string :raw_affiliation_string

      t.timestamps
    end
  end
end
