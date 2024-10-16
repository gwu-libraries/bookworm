require 'rake'
require 'zlib'
require 'csv'

namespace :data_import do
  desc 'Load InstitutionsIds from gzipped csv to db'
  task load_institutions_ids: :environment do
    institution_ids = []

    Zlib::GzipReader.open(
      '/opt/bookworm/csv-files/institutions_ids.csv.gz'
    ) do |gzip|
      csv = CSV.new(gzip)
      csv
        .drop(1)
        .each_with_index do |row, index| # drop(1) handles the header row
          institution = Institution.find_by(openalex_id: row[0].split('/').last)

          institution_ids << {
            institution_id: institution.id,
            openalex: row[0].split('/').last,
            ror: row[2],
            grid: row[3],
            wikipedia: row[4],
            wikidata: row[5],
            mag: row[6]
          }
        end
    end

    InstitutionsIds.insert_all(institution_ids)
  end
end
