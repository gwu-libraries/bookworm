require 'rake'
require 'zlib'
require 'csv'

namespace :data_import do
  desc 'Load Sources from gzipped csv'
  task load_sources: :environment do
    file_path = '/opt/bookworm/csv-files/sources.csv.gz'

    Zlib::GzipReader.open(file_path) do |gzip|
      csv = CSV.new(gzip)
      sources = []

      csv.each_with_index do |row, index|
        unless index == 0
          sources << {
            source_openalex_id: row[0].split('/').last,
            issn_l: row[1],
            issn: row[2],
            display_name: row[3],
            publisher: row[4],
            works_count: row[5],
            cited_by_count: row[6],
            is_oa: row[7],
            is_in_doaj: row[8],
            homepage_url: row[9],
            works_api_url: row[10]
          }
        end

        if sources.count >= 10_000
          Source.insert_all(sources)

          sources = []
        end
      end
      Source.insert_all(sources)
    end
  end
end
