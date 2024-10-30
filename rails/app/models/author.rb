# frozen_string_literal: true

class Author < ApplicationRecord
  has_one :authors_ids
  has_many :authors_counts_by_year
  has_many :works_authorships,
           primary_key: :openalex_id,
           foreign_key: :author_openalex_id
  has_many :institutions, through: :works_authorships
end
