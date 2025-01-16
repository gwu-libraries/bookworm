require 'rake'
require 'zlib'
require 'csv'

namespace :data_import do
  desc 'Load InstitutionsAssociatedInstitutions from gzipped csv to db'
  task load_institutions_associated_institutions: :environment do
    institutions_associated_institutions = []

    Zlib::GzipReader.open(
      '/opt/bookworm/csv-files/institutions_associated_institutions.csv.gz'
    ) do |gzip|
      csv = CSV.new(gzip)
      csv.each_with_index do |row, index| # drop(1) handles the header row
        unless index == 0
          institutions_associated_institutions << {
            institution_openalex_id: row[0].split('/').last,
            associated_institution_openalex_id: row[1].split('/').last,
            relationship: row[2]
          }
        end

        if institutions_associated_institutions.count >= 100_000
          InstitutionsAssociatedInstitutions.insert_all(
            institutions_associated_institutions
          )

          institutions_associated_institutions = []
        end
      end
    end

    InstitutionsAssociatedInstitutions.insert_all(
      institutions_associated_institutions
    )
  end
end
