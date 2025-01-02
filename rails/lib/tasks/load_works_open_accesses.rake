require 'rake'
require 'zlib'
require 'csv'

namespace :data_import do
  desc 'Load WorksOpenAccess from gzipped csv to db'
  task load_works_open_accesses: :environment do
    file_paths = Dir['/opt/bookworm/csv-files/works_open_access.csv.gz']

    file_paths.each do |file_path|
      Zlib::GzipReader.open(file_path) do |gzip|
        works_open_accesses = []
        csv = CSV.new(gzip)
        csv.each_with_index do |row, index|
          unless index == 0
            works_open_accesses << {
              work_openalex_id: row[0].split('/').last,
              is_oa: ActiveModel::Type::Boolean.new.cast(row[1].downcase),
              oa_status: row[2],
              oa_url: row[3],
              any_repository_has_fulltext:
                ActiveModel::Type::Boolean.new.cast(row[4].downcase)
            }
          end

          if works_open_accesses.count >= 100_000
            WorksOpenAccess.insert_all(works_open_accesses)

            works_open_accesses = []
          end
        end
        WorksOpenAccess.insert_all(works_open_accesses)
      end
    end
  end
end
