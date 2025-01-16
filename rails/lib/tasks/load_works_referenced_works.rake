require 'rake'
require 'zlib'
require 'csv'

namespace :data_import do
  desc 'Load WorksReferencedWorks from gzipped csv to db'
  task load_works_referenced_works: :environment do
    file_paths = Dir['/opt/bookworm/csv-files/works_referenced_works.csv.gz']

    file_paths.each do |file_path|
      Zlib::GzipReader.open(file_path) do |gzip|
        works_referenced_works = []
        csv = CSV.new(gzip)
        csv.each_with_index do |row, index|
          if index >= 1_407_400_000
            works_referenced_works << {
              work_openalex_id: row[0].split('/').last,
              referenced_work_openalex_id: row[1].split('/').last
            }
          end

          if works_referenced_works.count >= 100_000
            WorksReferencedWorks.insert_all(works_referenced_works)

            works_referenced_works = []
          end
        end
        WorksReferencedWorks.insert_all(works_referenced_works)
      end
    end
  end
end
