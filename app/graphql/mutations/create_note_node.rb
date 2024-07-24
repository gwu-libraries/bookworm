# frozen_string_literal: true

module Mutations
  class CreateNoteNode < BaseMutation
    argument :body_text, String
    argument :investigation_id, Integer

    type 'Types::NoteNodeType'

    def resolve(**attributes)
      authorize_user

      user = context[:current_user]

      note =
        NoteNode.create(
          investigation_id: attributes[:investigation_id],
          body_text: attributes[:body_text]
        )

      note.persisted? ? note : 'uhoh'
    end
  end
end
