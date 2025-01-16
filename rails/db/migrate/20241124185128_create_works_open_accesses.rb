class CreateWorksOpenAccesses < ActiveRecord::Migration[7.1]
  def change
    create_table :works_open_accesses do |t|
      t.string :work_openalex_id
      t.boolean :is_oa
      t.string :oa_status
      t.string :oa_url
      t.boolean :any_repository_has_fulltext

      t.timestamps
    end

    add_index :works_open_accesses, :work_openalex_id
  end
end
