require 'rake'
require 'zlib'
require 'csv'

namespace :data_import do
  desc 'Load PublishersIds from gzipped csv to db'
  task load_publishers_ids: :environment do
    file_path = '/opt/bookworm/csv-files/publishers_ids.csv.gz'
    publishers_ids = []
    Zlib::GzipReader.open(file_path) do |gzip|
      csv = CSV.new(gzip)

      csv.each_with_index do |row, index|
        publisher = Publisher.find_by(openalex_id: row[0].split('/').last)

        unless publisher.nil?
          publishers_ids << {
            publisher_id: publisher.id,
            openalex: row[1].split('/').last,
            ror: row[2],
            wikidata: row[3]
          }
        end

        if publishers_ids.count >= 1000
          PublishersIds.insert_all(publishers_ids)

          publishers_ids = []
        end
      end
    end
    PublishersIds.insert_all(publishers_ids)
  end
end
