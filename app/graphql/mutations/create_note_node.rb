# frozen_string_literal: true

module Mutations
  class CreateNoteNode < BaseMutation
    argument :body_text, String
    argument :investigation_id, Integer

    type 'Types::NoteNodeType'

    def resolve(**attributes)
      authorize_user

      user = context[:current_user]

      note_node =
        NoteNode.create(
          investigation_id: attributes[:investigation_id],
          body_text: attributes[:body_text]
        )

      note_node.x_coordinate = rand(1000) unless note_node.x_coordinate.present?
      note_node.y_coordinate = rand(1000) unless note_node.y_coordinate.present?
      note_node.visible = true

      note_node.save

      note_node.persisted? ? note_node : 'uhoh'
    end
  end
end
