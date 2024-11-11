require 'rake'
require 'zlib'
require 'csv'

namespace :data_import do
  desc 'Load SourcesIds from gzipped csv to db'
  task load_sources_ids: :environment do
    file_paths = Dir['/opt/bookworm/csv-files/sources_ids.csv.gz']

    file_paths.each do |file_path|
      Zlib::GzipReader.open(file_path) do |gzip|
        sources_ids = []
        csv = CSV.new(gzip)
        csv.each_with_index do |row, index|
          unless index == 0
            sources_ids << {
              source_openalex_id: row[0].split('/').last,
              issn_l: row[2],
              issn: row[3],
              mag: row[4],
              wikidata: row[5],
              fatcat: row[6]
            }
          end

          if sources_ids.count >= 10_000
            SourcesIds.insert_all(sources_ids)

            sources_ids = []
          end
        end
        SourcesIds.insert_all(sources_ids)
      end
    end
  end
end
