require 'rake'
require 'zlib'
require 'csv'

namespace :data_import do
  desc 'Load WorksTopics from gzipped csv to db'
  task load_works_topics: :environment do
    file_paths = Dir['/opt/bookworm/csv-files/works_topics.csv.gz']

    file_paths.each do |file_path|
      Zlib::GzipReader.open(file_path) do |gzip|
        works_topics = []
        csv = CSV.new(gzip)
        csv.each_with_index do |row, index|
          unless index == 0
            works_topics << {
              work_openalex_id: row[0].split('/').last,
              topic_openalex_id: row[1].split('/').last,
              score: row[2].to_f
            }
          end

          if works_topics.count >= 10_000
            WorksTopic.insert_all(works_topics)

            works_topics = []
          end
        end
        WorksTopic.insert_all(works_topics)
      end
    end
  end
end
