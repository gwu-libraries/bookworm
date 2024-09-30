class CreateInstitutionsGeos < ActiveRecord::Migration[7.1]
  def change
    create_table :institutions_geos do |t|
      t.references :institution, null: false, foreign_key: true
      t.string :city
      t.string :geonames_city_id
      t.string :region
      t.string :country_code
      t.string :country
      t.float :latitude
      t.float :longitude
      
    end
  end
end
