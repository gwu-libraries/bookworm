class AllowNullInstitutionInWorksAuthorship < ActiveRecord::Migration[7.1]
  def change
    change_column_null(:works_authorships, :institution_id, true)
  end
end
