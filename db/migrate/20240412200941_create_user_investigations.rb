class CreateUserInvestigations < ActiveRecord::Migration[7.1]
  def change
    create_table :user_investigations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :investigation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
