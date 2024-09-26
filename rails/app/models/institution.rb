# frozen_string_literal: true

class Institution < ApplicationRecord
  has_one :institutions_counts_by_year
  has_one :institutions_geo
  has_one :institutions_ids
end
