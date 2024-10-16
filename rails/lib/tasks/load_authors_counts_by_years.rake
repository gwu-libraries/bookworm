require 'rake'
require 'zlib'
require 'csv'

namespace :data_import do
  desc 'Load AuthorsCountsByYear from gzipped csv to db'
  task load_authors_counts_by_year: :environment do
    file_paths =
      Dir[
        '/opt/bookworm/csv-files/authors_counts_by_year/authors_counts_by_year_split*'
      ]

    file_paths.each do |file_path|
      authors_counts_by_year = []
      Zlib::GzipReader.open(file_path) do |gzip|
        csv = CSV.new(gzip)

        csv.each_with_index do |row, index| # drop(1) handles the header row
          author = Author.find_by(openalex_id: row[0].split('/').last)

          unless author.nil?
            authors_counts_by_year << {
              author_id: author.id,
              year: row[1],
              works_count: row[2],
              cited_by_count: row[3],
              oa_works_count: row[4]
            }
          end

          if authors_counts_by_year.count >= 1000
            AuthorsCountsByYear.insert_all(authors_counts_by_year)

            authors_counts_by_year = []
          end
        end
      end

      AuthorsCountsByYear.insert_all(authors_counts_by_year)
    end
  end
end
