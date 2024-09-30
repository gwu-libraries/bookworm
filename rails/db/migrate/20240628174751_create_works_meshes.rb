class CreateWorksMeshes < ActiveRecord::Migration[7.1]
  def change
    create_table :works_meshes do |t|
      t.references :work, null: false, foreign_key: true
      t.string :descriptor_ui
      t.string :descriptor_name
      t.string :qualifier_ui
      t.string :qualifier_name
      t.boolean :is_major_topic

    end
  end
end
