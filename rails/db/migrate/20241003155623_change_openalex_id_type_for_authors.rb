class ChangeOpenalexIdTypeForAuthors < ActiveRecord::Migration[7.1]
  def change
    change_column(:authors, :openalex_id, :string)
  end
end
