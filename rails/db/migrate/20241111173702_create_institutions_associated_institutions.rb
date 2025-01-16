class CreateInstitutionsAssociatedInstitutions < ActiveRecord::Migration[7.1]
  def change
    create_table :institutions_associated_institutions do |t|
      t.string :institution_openalex_id
      t.string :associated_institution_openalex_id
      t.string :relationship

      t.timestamps
    end

    add_index :institutions_associated_institutions, :institution_openalex_id
    add_index :institutions_associated_institutions,
              :associated_institution_openalex_id
  end
end
