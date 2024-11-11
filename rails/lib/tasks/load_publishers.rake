require 'rake'
require 'zlib'
require 'csv'

namespace :data_import do
  desc 'Load Publishers from gzipped csv'
  task load_publishers: :environment do
    file_path = '/opt/bookworm/csv-files/publishers.csv.gz'

    Zlib::GzipReader.open(file_path) do |gzip|
      publishers = []
      csv = CSV.new(gzip)

      csv.each_with_index do |row, index|
        unless index == 0
          publishers << {
            publisher_openalex_id: row[0].split('/').last,
            display_name: row[1],
            alternate_titles: row[2],
            country_codes: row[3],
            hierarchy_level: row[4],
            parent_publisher: row[5],
            works_count: row[6],
            cited_by_count: row[7],
            sources_api_url: row[8]
          }
        end

        if publishers.count >= 10_000
          Publisher.insert_all(publishers)

          publishers = []
        end
      end
      Publisher.insert_all(publishers)
    end
  end
end
