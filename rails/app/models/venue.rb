# frozen_string_literal: true

class Venue < ApplicationRecord
  has_one :venues_counts_by_year
  has_one :venues_ids
  has_many :works
  has_many :works_alternate_host_venues
end
