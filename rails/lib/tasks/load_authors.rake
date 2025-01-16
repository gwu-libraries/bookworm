require 'rake'
require 'zlib'
require 'csv'

namespace :data_import do
  desc 'Load Authors from gzipped csv to db'
  task load_authors: :environment do
    file_paths = Dir['/opt/bookworm/csv-files/authors.csv.gz']

    file_paths.each do |file_path|
      authors = []
      Zlib::GzipReader.open(file_path) do |gzip|
        csv = CSV.new(gzip)
        csv.each_with_index do |row, index|
          unless index == 0
            authors << {
              author_openalex_id: row[0].split('/').last,
              orcid: row[1],
              display_name: row[2],
              display_name_alternatives: row[3],
              works_count: row[4].to_i,
              cited_by_count: row[5].to_i,
              last_known_institution: row[6],
              works_api_url: row[7]
            }
          end

          if authors.count >= 10_000
            Author.insert_all(authors)

            authors = []
          end
        end
      end
      Author.insert_all(authors)
    end
  end
end
