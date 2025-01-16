class CreateWorksTopics < ActiveRecord::Migration[7.1]
  def change
    create_table :works_topics do |t|
      t.string :work_openalex_id
      t.string :topic_openalex_id
      t.float :score

      t.timestamps
    end

    add_index :works_topics, :work_openalex_id
    add_index :works_topics, :topic_openalex_id
  end
end
