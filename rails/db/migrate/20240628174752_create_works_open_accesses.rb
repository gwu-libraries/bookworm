class CreateWorksOpenAccesses < ActiveRecord::Migration[7.1]
  def change
    create_table :works_open_accesses do |t|
      t.references :work, null: false, foreign_key: true
      t.boolean :is_oa
      t.string :oa_status
      t.string :oa_url
      t.boolean :any_repository_has_fulltext
    end
  end
end
