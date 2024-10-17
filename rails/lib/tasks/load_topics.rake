require 'rake'
require 'zlib'
require 'csv'
require 'json'

namespace :data_import do
  desc 'Load Topics from gzipped csv to db'
  task load_topics: :environment do
    file_path = '/opt/bookworm/csv-files/topics.csv.gz'
    topics = []

    Zlib::GzipReader.open(file_path) do |gzip|
      csv = CSV.new(gzip)
      csv
        .drop(1)
        .each_with_index do |row, index|
          topics << {
            openalex_id: row[0].split('/').last,
            display_name: row[1],
            subfield_id: row[2].split('/').last,
            subfield_display_name: row[3],
            field_id: row[4].split('/').last,
            field_display_name: row[5],
            domain_id: row[6].split('/').last,
            domain_display_name: row[7],
            description: row[8],
            keywords: row[9].split('; '),
            works_api_url: row[10],
            wikipedia_id: row[11],
            works_count: row[12],
            cited_by_count: row[13]
          }
        end
    end

    Topic.insert_all(topics)
  end
end
