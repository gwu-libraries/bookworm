require 'rake'
require 'zlib'
require 'csv'
require 'json'

namespace :data_import do
  desc 'Load Topics from gzipped csv to db'
  task load_topics: :environment do
    file_path = '/opt/bookworm/csv-files/topics.csv.gz'

    Zlib::GzipReader.open(file_path) do |gzip|
      csv = CSV.new(gzip)
      topics = []
      csv.each_with_index do |row, index|
        unless index == 0
          topics << {
            topic_openalex_id: row[0].split('/').last,
            display_name: row[1],
            openalex_subfield_id: row[2].split('/').last,
            openalex_subfield_display_name: row[3],
            openalex_field_id: row[4].split('/').last,
            openalex_field_display_name: row[5],
            openalex_domain_id: row[6].split('/').last,
            openalex_domain_display_name: row[7],
            description: row[8],
            keywords: row[9].split('; '),
            works_api_url: row[10],
            wikipedia_id: row[11],
            works_count: row[12],
            cited_by_count: row[13]
          }
        end

        if topics.count >= 10_000
          Topic.insert_all(topics)

          topics = []
        end
      end
      Topic.insert_all(topics)
    end
  end
end
