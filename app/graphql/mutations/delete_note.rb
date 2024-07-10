# frozen_string_literal: true

module Mutations
  class DeleteNote < BaseMutation
    argument :investigation_id, Integer, required: true
    argument :note_id, Integer, required: true # should probably be ID type

    type Types::NoteType

    def resolve(**attributes)
      authorize_user

      note = Note.find(attributes[:note_id])

      if note.investigation.user != context[:current_user]
        'Unauthorized'
      else
        note.delete

        MutationResult.call(
          obj: {
            object: note
          },
          success: true,
          errors: 'uhoh'
        )
      end
    end
  end
end
