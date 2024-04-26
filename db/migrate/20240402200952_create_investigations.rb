class CreateInvestigations < ActiveRecord::Migration[7.1]
  def change
    create_table :investigations do |t|
      t.string :name

      t.timestamps
    end
  end
end
