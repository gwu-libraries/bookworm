# frozen_string_literal: true

module Mutations
  class CreateNote < BaseMutation
    argument :body_text, String
    argument :investigation_id, Integer

    type Types::NoteType

    def resolve(**attributes)
      authorize_user

      user = context[:current_user]

      note = Note.create(investigation_id: attributes[:investigation_id],
      body_text: attributes[:body_text])

      if note.persisted?
        note
      else
        "uhoh"
      end
    end
  end
end