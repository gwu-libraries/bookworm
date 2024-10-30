class AllowNullWorkInWorksAuthorship < ActiveRecord::Migration[7.1]
  def change
    change_column_null(:works_authorships, :work_id, true)
  end
end
