# frozen_string_literal: true

class Author < ApplicationRecord
  has_one :authors_ids,
          primary_key: :author_openalex_id,
          foreign_key: :author_openalex_id
  has_many :authors_counts_by_year,
           primary_key: :author_openalex_id,
           foreign_key: :author_openalex_id
  has_many :works_authorships,
           primary_key: :author_openalex_id,
           foreign_key: :author_openalex_id
  has_many :institutions, through: :works_authorships
  has_many :works, through: :works_authorships
end
