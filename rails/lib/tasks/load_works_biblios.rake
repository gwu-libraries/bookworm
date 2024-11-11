require 'rake'
require 'zlib'
require 'csv'

namespace :data_import do
  desc 'Load WorksBiblios from gzipped csv to db'
  task load_works_biblios: :environment do
    file_paths = Dir['/opt/bookworm/csv-files/works_biblio.csv.gz']

    file_paths.each do |file_path|
      Zlib::GzipReader.open(file_path) do |gzip|
        works_biblios = []
        csv = CSV.new(gzip)
        csv.each_with_index do |row, index|
          unless index == 0
            works_biblios << {
              work_openalex_id: row[0].split('/').last,
              volume: row[1],
              issue: row[2],
              first_page: row[3],
              last_page: row[4]
            }
          end

          if works_biblios.count >= 10_000
            WorksBiblio.insert_all(works_biblios)

            works_biblios = []
          end
        end
        WorksBiblio.insert_all(works_biblios)
      end
    end
  end
end
