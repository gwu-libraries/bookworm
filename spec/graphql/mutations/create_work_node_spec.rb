# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::CreateWorkNode, type: :request do
  def create_work_node_mutation
    <<~GQL
      mutation ($doi: String!, $investigationId: Int!) {
        createWorkNode(input: { doi: $doi, investigationId: $investigationId }) {
          id
          xCoordinate
          yCoordinate
          visible
          work {
            title
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
    it 'can create a new work node', :vcr do
      response =
        BookWormApiSchema.execute(
          create_work_node_mutation,
          variables: {
            investigationId: @investigation_1.id,
            doi: '10.1145/3174781.3174785'
          },
          context: {
            current_user: @user_1
          }
        ).to_h

      expect(response).to be_a(Hash)
      expect(response.keys).to eq(['data'])
      expect(response['data']).to be_a(Hash)
      expect(response['data'].keys).to eq(['createWorkNode'])
      expect(response['data']['createWorkNode']).to be_a(Hash)
      expect(response['data']['createWorkNode'].keys).to eq(
        %w[id xCoordinate yCoordinate visible work]
      )
      expect(response['data']['createWorkNode']['work']).to be_a(Hash)
      expect(response['data']['createWorkNode']['work'].keys).to eq(['title'])
      expect(response['data']['createWorkNode']['work']['title']).to eq(
        "\"I know it when I see it\" Perceptions of Code Quality"
      )
    end
  end
end
