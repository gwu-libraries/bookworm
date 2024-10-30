class RenameTypeOnWorks < ActiveRecord::Migration[7.1]
  def change
    rename_column :works, :type, :work_type
  end
end
