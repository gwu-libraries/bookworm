# frozen_string_literal: true

class WorksConcept < ApplicationRecord
  belongs_to :work
  belongs_to :concept
end
