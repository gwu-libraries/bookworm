class CreateInstitutionsAssociatedInstitutions < ActiveRecord::Migration[7.1]
  def change
    create_table :institutions_associated_institutions do |t|
      t.string :institution_id
      t.string :associated_institution_id
      t.string :relationship
      
    end
  end
end
