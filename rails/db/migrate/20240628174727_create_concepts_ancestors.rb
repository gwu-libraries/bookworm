class CreateConceptsAncestors < ActiveRecord::Migration[7.1]
  def change
    create_table :concepts_ancestors do |t|
      t.string :concept_id, null: false
      t.string :ancestor_id, null: false
      # this needs to be that self-referential many-to-many situation

      t.timestamps
    end
  end
end
