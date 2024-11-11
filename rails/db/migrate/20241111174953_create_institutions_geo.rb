class CreateInstitutionsGeo < ActiveRecord::Migration[7.1]
  def change
    create_table :institutions_geos do |t|
      t.string :institution_openalex_id
      t.string :city
      t.integer :geonames_city_id
      t.string :region
      t.string :country_code
      t.string :country
      t.float :latitude
      t.float :longitude

      t.timestamps
    end

    add_index :institutions_geos, :institution_openalex_id
  end
end
