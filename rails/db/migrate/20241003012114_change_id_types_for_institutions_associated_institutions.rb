class ChangeIdTypesForInstitutionsAssociatedInstitutions < ActiveRecord::Migration[
  7.1
]
  def up
    connection.execute(
      '
      alter table institutions_associated_institutions
      alter column institution_id
      type integer using cast(institution_id as integer)
    '
    )

    connection.execute(
      '
      alter table institutions_associated_institutions
      alter column associated_institution_id
      type integer using cast(associated_institution_id as integer)
    '
    )
  end
end
