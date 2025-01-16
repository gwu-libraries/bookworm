require 'rake'
require 'zlib'
require 'csv'

namespace :data_import do
  desc 'Load WorksPrimaryLocations from gzipped csv to db'
  task load_works_primary_locations: :environment do
    file_paths = Dir['/opt/bookworm/csv-files/works_primary_locations.csv.gz']

    file_paths.each do |file_path|
      Zlib::GzipReader.open(file_path) do |gzip|
        works_primary_locations = []
        csv = CSV.new(gzip)
        csv.each_with_index do |row, index|
          unless index == 0
            works_primary_locations << {
              work_openalex_id: row[0].split('/').last,
              source_openalex_id: row[1].split('/').last,
              landing_page_url: row[2],
              pdf_url: row[3],
              is_oa: ActiveModel::Type::Boolean.new.cast(row[4].downcase),
              version: row[5],
              license: row[6]
            }
          end

          if works_primary_locations.count >= 100_000
            WorksPrimaryLocation.insert_all(works_primary_locations)

            works_primary_locations = []
          end
        end
        WorksPrimaryLocation.insert_all(works_primary_locations)
      end
    end
  end
end
