# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::CreateAuthorNode, type: :request do
  def create_work_node_mutation
    <<~GQL
      mutation ($doi: String!, $investigationId: String!) {
        createWorkNode(input: { doi: $doi, investigationId: $investigationId }) {
          id
          xCoordinate
          yCoordinate
          visible
          work {
            title
            openalexId
          }
        }
      }
    GQL
  end

  def create_author_node_mutation
    <<~GQL
    mutation ($authorOpenalexId: String!, $workOpenalexId: String!, $investigationId: String!) {
      createAuthorNode(
        input: { authorOpenalexId: $authorOpenalexId, workOpenalexId: $workOpenalexId, investigationId: $investigationId }
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

  describe '.resolve' do
    it 'can create an author node', :vcr do
      user_1 = FactoryBot.create(:user)
      investigation_1 = FactoryBot.create(:investigation, user_id: user_1.id)

      work_node_response =
        BookWormSchema.execute(
          create_work_node_mutation,
          variables: {
            investigationId: investigation_1.id.to_s,
            doi: '10.1145/3174781.3174785'
          },
          context: {
            current_user: user_1
          }
        ).to_h

      response =
        BookWormSchema.execute(
          create_author_node_mutation,
          variables: {
            authorOpenalexId: 'A5023888391',
            workOpenalexId:
              work_node_response['data']['createWorkNode']['work'][
                'openalexId'
              ],
            investigationId: investigation_1.id.to_s
          },
          context: {
            current_user: user_1
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
