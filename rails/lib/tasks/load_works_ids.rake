require 'rake'
require 'zlib'
require 'csv'

namespace :data_import do
  desc 'Load WorksIds from gzipped csv to db'
  task load_works_ids: :environment do
    file_paths = Dir['/opt/bookworm/csv-files/works_ids.csv.gz']

    file_paths.each do |file_path|
      works_ids = []
      Zlib::GzipReader.open(file_path) do |gzip|
        csv = CSV.new(gzip)
        csv.each_with_index do |row, index| # drop(1) handles the header row
          unless index == 0
            works_ids << {
              work_openalex_id: row[0].split('/').last,
              doi: row[2],
              mag: row[3],
              pmid: row[4],
              pmcid: row[5]
            }
          end

          if works_ids.count >= 10_000
            WorksIds.insert_all(works_ids)

            works_ids = []
          end
        end
      end

      WorksIds.insert_all(works_ids)
    end
  end
end
