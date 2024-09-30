class CreateWorksTopics < ActiveRecord::Migration[7.1]
  def change
    create_table :works_topics do |t|
      t.references :work, null: false, foreign_key: true
      t.references :topic, null: false, foreign_key: true
      t.float :score

    end
  end
end
