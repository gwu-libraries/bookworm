require 'rake'
require 'zlib'
require 'csv'

namespace :data_import do
  desc 'Load Works from gzipped csv to db'
  task load_works: :environment do
    file_paths = Dir['/opt/bookworm/csv-files/works.csv.gz']

    file_paths.each do |file_path|
      Zlib::GzipReader.open(file_path) do |gzip|
        csv = CSV.new(gzip, encoding: 'utf-8')
        works = []

        csv.each_with_index do |row, index|
          unless index == 0
            works << {
              work_openalex_id: row[0].split('/').last,
              doi: row[1],
              title: row[2],
              display_name: row[3],
              publication_year: row[4],
              publication_date: row[5],
              work_type: row[6],
              cited_by_count: row[7],
              is_retracted: row[8],
              is_paratext: row[9],
              cited_by_api_url: row[10],
              abstract_inverted_index: row[11],
              language: row[12]
            }
          end

          if works.count >= 5000
            Work.insert_all(works)
            works = []
          end
        end
        Work.insert_all(works)
      end
    end
  end
end
