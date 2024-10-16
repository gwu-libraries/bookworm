require 'rake'
require 'zlib'
require 'csv'

namespace :data_import do
  desc 'Load PublishersCountsByYear from gzipped csv to db'
  task load_publishers_counts_by_year: :environment do
    file_path = '/opt/bookworm/csv-files/publishers_counts_by_year.csv.gz'

    publishers_counts_by_years = []
    Zlib::GzipReader.open(file_path) do |gzip|
      csv = CSV.new(gzip)

      csv.each_with_index do |row, index|
        publisher = Publisher.find_by(openalex_id: row[0].split('/').last)

        unless publisher.nil?
          publishers_counts_by_years << {
            publisher_id: publisher.id,
            year: row[1],
            works_count: row[2],
            cited_by_count: row[3],
            oa_works_count: row[4]
          }
        end

        if publishers_counts_by_years.count >= 1000
          PublishersCountsByYear.insert_all(publishers_counts_by_years)

          publishers_counts_by_years = []
        end
      end
    end

    PublishersCountsByYear.insert_all(publishers_counts_by_years)
  end
end