# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::CreateAuthorNode, type: :request do
  def create_author_node_mutation
    <<~GQL
    mutation ($openalexId: String!, $investigationId: Int!) {
      createAuthorNode(
        input: { openalexId: $openalexId, investigationId: $investigationId }
      ) {
        xCoordinate
        yCoordinate
        visible
        author {
          name
        }
      }
    }
    GQL
  end

  before :all do
    @user_1 = FactoryBot.create(:user)
    @investigation_1 = FactoryBot.create(:investigation, user_id: @user_1.id)
  end

  describe '.resolve' do
    it 'can create an author node', :vcr do
      response =
        BookWormApiSchema.execute(
          create_author_node_mutation,
          variables: {
            openalexId: 'A5023888391',
            investigationId: @investigation_1.id
          },
          context: {
            current_user: @user_1
          }
        ).to_h

      expect(response).to be_a(Hash)
      expect(response.keys).to eq(['data'])
      expect(response['data'].keys).to eq(['createAuthorNode'])
      expect(response['data']['createAuthorNode'].keys).to eq(
        %w[xCoordinate yCoordinate visible author]
      )
      expect(response['data']['createAuthorNode']['author']).to be_a(Hash)
      expect(response['data']['createAuthorNode']['author']['name']).to eq(
        'Jason Priem'
      )
    end
  end
end
