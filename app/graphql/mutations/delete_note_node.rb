# frozen_string_literal: true

module Mutations
  class DeleteNoteNode < BaseMutation
    argument :investigation_id, Integer, required: true
    argument :note_node_id, Integer, required: true # should probably be ID type

    type 'Types::NoteNodeType'

    def resolve(**attributes)
      authorize_user

      note = NoteNode.find(attributes[:note_node_id])

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
