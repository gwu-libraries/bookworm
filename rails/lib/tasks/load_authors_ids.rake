require 'rake'
require 'zlib'
require 'csv'

namespace :data_import do
  desc 'Load AuthorsIds from gzipped csv to db'
  task load_authors_ids: :environment do
    file_paths = Dir['/opt/bookworm/csv-files/authors_ids.csv.gz']

    file_paths.each do |file_path|
      authors_ids = []
      Zlib::GzipReader.open(file_path) do |gzip|
        csv = CSV.new(gzip)
        csv.each_with_index do |row, index| # drop(1) handles the header row
          unless index == 0
            authors_ids << {
              author_openalex_id: row[1].split('/').last,
              orcid: row[2],
              scopus: row[3],
              twitter: row[4],
              wikipedia: row[5],
              mag: row[6]
            }
          end

          if authors_ids.count >= 10_000
            AuthorsIds.insert_all(authors_ids)

            authors_ids = []
          end
        end
      end

      AuthorsIds.insert_all(authors_ids)
    end
  end
end
