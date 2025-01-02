require 'rake'
require 'zlib'
require 'csv'

namespace :data_import do
  desc 'Load Works from gzipped csv to db'
  task load_works: :environment do
    scrub_converter = lambda { |field, _| field.try(:scrub) }

    works = []
    CSV.foreach(
      ('/opt/bookworm/csv-files/works.csv'),
      headers: true,
      col_sep: ',',
      converters: [scrub_converter]
    ) do |row|
      works << {
        work_openalex_id: row[0].split('/').last,
        doi: row[1],
        title: row[2],
        display_name: row[3],
        publication_year: row[4],
        publication_date: row[5],
        work_type: row[6],
        cited_by_count: row[7],
        is_retracted: ActiveModel::Type::Boolean.new.cast(row[8].downcase),
        is_paratext: ActiveModel::Type::Boolean.new.cast(row[9].downcase),
        cited_by_api_url: row[10],
        abstract_inverted_index: row[11],
        language: row[12]
      }

      if works.count >= 5000
        Work.insert_all(works)
        works = []
      end
    end
    Work.insert_all(works)
  end
end
