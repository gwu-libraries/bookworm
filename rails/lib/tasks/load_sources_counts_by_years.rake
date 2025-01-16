require 'rake'
require 'zlib'
require 'csv'

namespace :data_import do
  desc 'Load SourcesCountsByYears from gzipped csv to db'
  task load_sources_counts_by_years: :environment do
    file_paths = Dir['/opt/bookworm/csv-files/sources_counts_by_year.csv.gz']

    file_paths.each do |file_path|
      Zlib::GzipReader.open(file_path) do |gzip|
        csv = CSV.new(gzip)
        sources_counts_by_year = []

        csv.each_with_index do |row, index| # drop(1) handles the header row
          unless index == 0
            sources_counts_by_year << {
              source_openalex_id: row[0].split('/').last,
              year: row[1],
              works_count: row[2],
              cited_by_count: row[3],
              oa_works_count: row[4]
            }
          end

          if sources_counts_by_year.count >= 10_000
            SourcesCountsByYear.insert_all(sources_counts_by_year)

            sources_counts_by_year = []
          end
        end
        SourcesCountsByYear.insert_all(sources_counts_by_year)
      end
    end
  end
end
