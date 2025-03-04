# frozen_string_literal: true

class Publisher < ApplicationRecord
  has_one :publishers_ids,
          primary_key: :publisher_openalex_id,
          foreign_key: :publisher_openalex_id

  has_many :publishers_counts_by_year,
           primary_key: :publisher_openalex_id,
           foreign_key: :publisher_openalex_id
end
