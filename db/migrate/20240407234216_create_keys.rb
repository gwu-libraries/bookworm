class CreateKeys < ActiveRecord::Migration[7.1]
  def change
    create_table :keys do |t|
      t.integer :user_id
      t.string :site
      t.string :value

      t.timestamps
    end
  end
end
