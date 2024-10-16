require 'rake'
require 'zlib'
require 'csv'

namespace :data_import do
  desc 'Load InstitutionsCountsByYear from gzipped csv to db'
  task load_institutions_counts_by_year: :environment do
    institutions_counts_by_years = []

    Zlib::GzipReader.open(
      '/opt/bookworm/csv-files/institutions_counts_by_year.csv.gz'
    ) do |gzip|
      csv = CSV.new(gzip)

      csv
        .drop(1)
        .each_with_index do |row, index| # drop(1) handles the header row
          institution = Institution.find_by(openalex_id: row[0].split('/').last)

          institutions_counts_by_years << {
            institution_id: institution.id,
            year: row[1],
            works_count: row[2],
            cited_by_count: row[3],
            oa_works_count: row[4]
          }

          if institutions_counts_by_years.count >= 100
            InstitutionsCountsByYear.insert_all(institutions_counts_by_years)

            institutions_counts_by_years = []
          end
        end
    end

    InstitutionsCountsByYear.insert_all(institutions_counts_by_years)
  end
end
