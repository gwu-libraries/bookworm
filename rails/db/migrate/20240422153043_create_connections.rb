# frozen_string_literal: true

class CreateConnections < ActiveRecord::Migration[7.1]
  def change
    create_table :connections do |t|
      t.integer :reference_id, null: false
      t.integer :citation_id, null: false

      t.timestamps
    end
  end
end

# create an InvestigationConnection model, for associating edges with an investigation?

# how else to represent edges?

# just make edges lol
