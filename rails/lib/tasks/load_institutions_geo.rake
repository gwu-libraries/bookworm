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
      csv
        .drop(1)
        .each_with_index do |row, index| # drop(1) handles the header row
          institution = Institution.find_by(openalex_id: row[0].split('/').last)

          institutions_geos << {
            institution_id: institution.id,
            city: row[1],
            geonames_city_id: row[2],
            region: row[3],
            country_code: row[4],
            country: row[5],
            latitude: row[6],
            longitude: row[7]
          }

          if institutions_geos.count >= 100
            InstitutionsGeo.insert_all(institutions_geos)

            institutions_geos = []
          end
        end
    end

    InstitutionsGeo.insert_all(institutions_geos)
  end
end
