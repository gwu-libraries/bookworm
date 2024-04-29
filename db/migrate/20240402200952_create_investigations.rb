# frozen_string_literal: true

class CreateInvestigations < ActiveRecord::Migration[7.1]
  def change
    create_table :investigations do |t|
      t.integer :user_id
      t.string :name

      t.timestamps
    end
  end
end
