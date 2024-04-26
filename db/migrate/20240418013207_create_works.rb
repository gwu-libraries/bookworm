class CreateWorks < ActiveRecord::Migration[7.1]
  def change
    create_table :works do |t|
      t.string :doi
      t.string :title

      t.timestamps
    end
  end
end
