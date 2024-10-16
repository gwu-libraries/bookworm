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

      csv
        .drop(1)
        .each_with_index do |row, index| # drop(1) handles the header row
          institution = Institution.find_by(openalex_id: row[0].split('/').last)

          associated_institution =
            Institution.find_by(openalex_id: row[1].split('/').last)

          unless institution.nil? || associated_institution.nil?
            institutions_associated_institutions << {
              institution_id: institution.id,
              associated_institution_id: associated_institution.id,
              relationship: row[2]
            }
          end

          if institutions_associated_institutions.count >= 100
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
