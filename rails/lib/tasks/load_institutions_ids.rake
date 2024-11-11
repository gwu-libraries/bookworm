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
      csv.each_with_index do |row, index|
        unless index == 0
          institution_ids << {
            institution_openalex_id: row[0].split('/').last,
            ror: row[2],
            grid: row[3],
            wikipedia: row[4],
            wikidata: row[5],
            mag: row[6]
          }
        end

        if institution_ids.count >= 10_000
          InstitutionsIds.insert_all(institution_ids)

          institution_ids = []
        end
      end
    end

    InstitutionsIds.insert_all(institution_ids)
  end
end
