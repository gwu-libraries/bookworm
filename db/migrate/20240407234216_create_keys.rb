class CreateKeys < ActiveRecord::Migration[7.1]
  def change
    create_table :keys do |t|
      t.string :site
      t.string :value

      t.timestamps
    end
  end
end
