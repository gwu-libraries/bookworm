class AllowNullAuthorInWorksAuthorship < ActiveRecord::Migration[7.1]
  def change
    change_column_null(:works_authorships, :author_id, true)
  end
end
