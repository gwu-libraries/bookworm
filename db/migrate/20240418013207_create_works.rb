class CreateWorks < ActiveRecord::Migration[7.1]
  def change
    create_table :works do |t|
      t.integer :investigation_id
      t.string :doi
      t.string :title

      t.timestamps
    end
  end
end
