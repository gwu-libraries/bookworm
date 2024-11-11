require 'rake'
require 'zlib'
require 'csv'

namespace :data_import do
  desc 'Load WorksAuthorships from gzipped csv to db'
  task load_works_authorships: :environment do
    file_paths =
      Dir['/opt/bookworm/csv-files/works_authorships/works_authorships.csv.gz']

    file_paths.each do |file_path|
      Zlib::GzipReader.open(file_path) do |gzip|
        works_authorships = []
        csv = CSV.new(gzip)
        csv # .drop(1)
          .each_with_index do |row, index|
          work_openalex_id = row[0].present? ? row[0].split('/').last : nil
          author_openalex_id = row[2].present? ? row[2].split('/').last : nil
          institution_openalex_id =
            row[3].present? ? row[3].split('/').last : nil

          works_authorships << {
            work_openalex_id: work_openalex_id,
            author_position: row[1],
            author_openalex_id: author_openalex_id,
            institution_openalex_id: institution_openalex_id,
            raw_affiliation_string: row[4]
          }

          if works_authorships.count >= 10_000
            WorksAuthorship.insert_all(works_authorships)

            works_authorships = []
          end
        end
      end
    end
  end
end
