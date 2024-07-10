# frozen_string_literal: true

module Mutations
  class DeleteNote < BaseMutation
    argument :investigation_id, Integer, required: true
    argument :note_id, Integer, required: true # should probably be ID type

    type Types::NoteType

    def resolve(**attributes)
    end
  end
end
