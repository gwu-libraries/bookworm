require 'rake'
require 'zlib'
require 'csv'

namespace :data_import do
  desc 'Load Institutions from gzipped csv to db'
  task load_institutions: :environment do
    institutions = []

    Zlib::GzipReader.open(
      '/opt/bookworm/csv-files/institutions.csv.gz'
    ) do |gzip|
      csv = CSV.new(gzip)
      csv.each_with_index do |row, index|
        unless index == 0
          institutions << {
            institution_openalex_id: row[0].split('/').last,
            ror: row[1],
            display_name: row[2],
            country_code: row[3],
            institution_type: row[4],
            homepage_url: row[5],
            image_url: row[6],
            image_thumbnail_url: row[7],
            display_name_acronyms: row[8],
            display_name_alternatives: row[9],
            works_count: row[10],
            cited_by_count: row[11],
            works_api_url: row[12]
          }
        end

        if institutions.count >= 10_000
          Institution.insert_all(institutions)

          institutions = []
        end
      end
    end
    Institution.insert_all(institutions)
  end
end
