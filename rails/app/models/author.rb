# frozen_string_literal: true

class Author < ApplicationRecord
  has_one :authors_ids
  has_many :authors_counts_by_year
  has_many :works_authorships
  has_many :institutions, through: :works_authorships
end
