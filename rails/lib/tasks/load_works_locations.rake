require 'rake'
require 'zlib'
require 'csv'

namespace :data_import do
  desc 'Load WorksLocations from gzipped csv to db'
  task load_works_locations: :environment do
    file_paths = Dir['/opt/bookworm/csv-files/works_locations.csv.gz']

    file_paths.each do |file_path|
      Zlib::GzipReader.open(file_path) do |gzip|
        works_locations = []
        csv = CSV.new(gzip)
        csv.each_with_index do |row, index|
          unless index == 0
            works_locations << {
              work_openalex_id: row[0].split('/').last,
              source_openalex_id: row[1].split('/').last,
              landing_page_url: row[2],
              pdf_url: row[3],
              is_oa: row[4],
              version: row[5],
              license: row[6]
            }
          end

          if works_locations.count >= 10_000
            WorksLocation.insert_all(works_locations)

            works_locations = []
          end
        end
        WorksLocation.insert_all(works_locations)
      end
    end
  end
end
