require 'rake'
require 'zlib'
require 'csv'

namespace :data_import do
  desc 'Load WorksRelatedWorks from gzipped csv to db'
  task load_works_related_works: :environment do
    file_paths = Dir['/opt/bookworm/csv-files/works_related_works.csv.gz']

    file_paths.each do |file_path|
      Zlib::GzipReader.open(file_path) do |gzip|
        works_related_works = []
        csv = CSV.new(gzip)
        csv.each_with_index do |row, index|
          works_related_works << {
            work_id: row[0].split('/').last,
            related_work_id: row[1].split('/').last
          }

          if works_related_works.count >= 10_000
            WorksRelatedWorks.insert_all(works_related_works)

            works_related_works = []
          end
        end
      end
    end
  end
end
