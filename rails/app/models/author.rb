# frozen_string_literal: true

class Author < ApplicationRecord
  has_one :authors_ids
  has_one :authors_counts_by_year
end
