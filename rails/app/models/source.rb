# frozen_string_literal: true

class Source < ApplicationRecord
  has_one :sources_ids,
          primary_key: :source_openalex_id,
          foreign_key: :source_openalex_id

  has_many :sources_counts_by_year,
           primary_key: :source_openalex_id,
           foreign_key: :source_openalex_id
end
