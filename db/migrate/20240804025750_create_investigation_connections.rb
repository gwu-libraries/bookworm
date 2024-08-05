class CreateInvestigationConnections < ActiveRecord::Migration[7.1]
  def change
    create_table :investigation_connections do |t|
      t.references :investigation, null: false, foreign_key: true
      t.references :connection, null: false, foreign_key: true

      t.timestamps
    end
  end
end
