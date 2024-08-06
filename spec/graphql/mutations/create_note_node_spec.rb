# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::CreateNoteNode, type: :request do
  def create_note_node_mutation
    <<~GQL
      mutation ($investigationId: Int!, $bodyText: String!) {
        createNoteNode(
          input: { investigationId: $investigationId, bodyText: $bodyText }
        ) {
          bodyText
        }
      }
    GQL
  end

  before :all do
    @user_1 = FactoryBot.create(:user)

    @investigation_1 = FactoryBot.create(:investigation, user_id: @user_1.id)
  end

  it 'can create a new note node' do
    response =
      BookWormApiSchema.execute(
        create_note_node_mutation,
        variables: {
          investigationId: @investigation_1.id,
          bodyText: 'hey this is a new note node'
        },
        context: {
          current_user: @user_1
        }
      ).to_h

    expect(response).to be_a(Hash)
    expect(response.keys).to eq(['data'])
    expect(response['data'].keys).to eq(['createNoteNode'])
    expect(response['data']['createNoteNode'].keys).to eq(['bodyText'])
    expect(response['data']['createNoteNode']['bodyText']).to eq(
      'hey this is a new note node'
    )
  end
end
