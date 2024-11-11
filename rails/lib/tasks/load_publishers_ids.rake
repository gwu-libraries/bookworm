require 'rake'
require 'zlib'
require 'csv'

namespace :data_import do
  desc 'Load PublishersIds from gzipped csv to db'
  task load_publishers_ids: :environment do
    file_path = '/opt/bookworm/csv-files/publishers_ids.csv.gz'
    Zlib::GzipReader.open(file_path) do |gzip|
      csv = CSV.new(gzip)
      publishers_ids = []

      csv.each_with_index do |row, index|
        unless index == 0
          publishers_ids << {
            publisher_openalex_id: row[0].split('/').last,
            ror: row[2],
            wikidata: row[3]
          }
        end

        if publishers_ids.count >= 10_000
          PublishersIds.insert_all(publishers_ids)

          publishers_ids = []
        end
      end
      PublishersIds.insert_all(publishers_ids)
    end
  end
end
