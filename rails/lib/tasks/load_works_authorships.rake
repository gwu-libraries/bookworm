require 'rake'
require 'zlib'
require 'csv'

namespace :data_import do
  desc 'Load WorksAuthorships from gzipped csv to db'
  task load_works_authorships: :environment do
    file_paths = Dir['/opt/bookworm/csv-files/works_authorships.csv.gz']

    file_paths.each do |file_path|
      Zlib::GzipReader.open(file_path) do |gzip|
        works_authorships = []
        csv = CSV.new(gzip)
        csv.each_with_index do |row, index|
          unless index == 0
            works_authorships << {
              work_openalex_id: row[0].split('/').last,
              author_position: row[1],
              author_openalex_id: row[2].split('/').last,
              institution_openalex_id:
                row[3].present? ? row[3].split('/').last : nil,
              raw_affiliation_string: row[4]
            }
          end

          if works_authorships.count >= 10_000
            WorksAuthorship.insert_all(works_authorships)

            works_authorships = []
          end
        end
        WorksAuthorship.insert_all(works_authorships)
      end
    end
  end
end
