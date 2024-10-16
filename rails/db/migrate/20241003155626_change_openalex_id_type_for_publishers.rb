class ChangeOpenalexIdTypeForPublishers < ActiveRecord::Migration[7.1]
  def change
    change_column(:publishers, :openalex_id, :string)
  end
end
