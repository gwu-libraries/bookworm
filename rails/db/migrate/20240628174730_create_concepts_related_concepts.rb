class CreateConceptsRelatedConcepts < ActiveRecord::Migration[7.1]
  def change
    create_table :concepts_related_concepts do |t|
      t.string :concept_id
      t.string :related_concept_id
      t.float :score

      # another self-referential many-to-many
    end
  end
end
