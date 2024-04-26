class CreateUserKeys < ActiveRecord::Migration[7.1]
  def change
    create_table :user_keys do |t|
      t.references :user, null: false, foreign_key: true
      t.references :key, null: false, foreign_key: true

      t.timestamps
    end
  end
end
