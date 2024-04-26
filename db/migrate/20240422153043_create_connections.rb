class CreateConnections < ActiveRecord::Migration[7.1]
  def change
    create_table :connections do |t|
      t.integer :reference_id, null: false
      t.integer :citation_id, null: false

      t.timestamps
    end
  end
end
