# frozen_string_literal: true

class Publisher < ApplicationRecord
  has_one :publishers_ids
  has_many :publishers_counts_by_year
end
