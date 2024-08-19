# frozen_string_literal: true

RSpec.describe Mutations::DeleteNoteNode, type: :request do
  def create_note_node_mutation
    <<~GQL
      mutation ($investigationId: String!, $bodyText: String!) {
        createNoteNode(
          input: { investigationId: $investigationId, bodyText: $bodyText }
        ) {
          bodyText
          id
        }
      }
    GQL
  end

  def delete_note_node_mutation
    <<~GQL
      mutation ($investigationId: String!, $noteNodeId: String!) {
        deleteNoteNode(
          input: { investigationId: $investigationId, noteNodeId: $noteNodeId }
        ) {
          id
        }
      }
    GQL
  end

  context '.resolve' do
    it 'can delete a note node from an investigation' do
      user_1 = FactoryBot.create(:user)

      investigation_1 = FactoryBot.create(:investigation, user_id: user_1.id)

      note_node_response =
        BookWormApiSchema.execute(
          create_note_node_mutation,
          variables: {
            investigationId: investigation_1.id.to_s,
            bodyText: 'hey this is a new note node'
          },
          context: {
            current_user: user_1
          }
        ).to_h

      note_node_id = note_node_response['data']['createNoteNode']['id']

      expect(NoteNode.count).to eq(1)

      response =
        BookWormApiSchema.execute(
          delete_note_node_mutation,
          variables: {
            investigationId: investigation_1.id.to_s,
            noteNodeId: note_node_id.to_s
          },
          context: {
            current_user: user_1
          }
        ).to_h

      expect(NoteNode.count).to eq(0)
    end
  end
end
