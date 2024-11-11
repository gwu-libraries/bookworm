require 'rake'
require 'zlib'
require 'csv'

namespace :data_import do
  desc 'Load InstitutionsGeo from gzipped csv to db'
  task load_institutions_geo: :environment do
    institutions_geos = []

    Zlib::GzipReader.open(
      '/opt/bookworm/csv-files/institutions_geo.csv.gz'
    ) do |gzip|
      csv = CSV.new(gzip)
      csv.each_with_index do |row, index|
        unless index == 0
          institutions_geos << {
            institution_openalex_id: row[0].split('/').last,
            city: row[1],
            geonames_city_id: row[2],
            region: row[3],
            country_code: row[4],
            country: row[5],
            latitude: row[6],
            longitude: row[7]
          }
        end

        if institutions_geos.count >= 10_000
          InstitutionsGeo.insert_all(institutions_geos)

          institutions_geos = []
        end
      end
    end

    InstitutionsGeo.insert_all(institutions_geos)
  end
end
