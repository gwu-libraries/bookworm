# frozen_string_literal: true

module Mutations
  class AddCitations < BaseMutation
    argument :doi, String, required: true
    argument :investigation_id, Integer, required: true

    type Types::WorkType

    def resolve(**attributes)
    end
  end
end