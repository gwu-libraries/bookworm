# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::AddCitations, type: :request do
  def add_citations_mutation
    <<~GQL
      mutation ($openalexId: String!, $investigationId: String!) {
        addCitations(
          input: { openalexId: $openalexId, investigationId: $investigationId }
        ) {
          xCoordinate
          yCoordinate 
          visible
          work {
            openalexId
          }
        }
      }
    GQL
  end

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

  context '.resolve' do
    it "adds a work's citations to an investigation", :vcr do
      user_1 = FactoryBot.create(:user)

      investigation_1 = FactoryBot.create(:investigation, user_id: user_1.id)

      # create initial work node
      work_node_response =
        BookWormApiSchema.execute(
          create_work_node_mutation,
          variables: {
            investigationId: investigation_1.id.to_s,
            doi: '10.1145/3174781.3174785'
          },
          context: {
            current_user: user_1
          }
        ).to_h

      work_node_openalex_id =
        work_node_response['data']['createWorkNode']['work']['openalexId']

      response =
        BookWormApiSchema.execute(
          add_citations_mutation,
          variables: {
            openalexId: work_node_openalex_id,
            investigationId: investigation_1.id.to_s
          },
          context: {
            current_user: user_1
          }
        ).to_h

      expect(response).to be_a(Hash)
      expect(response.keys).to eq(['data'])
      expect(response['data'].keys).to eq(['addCitations'])
      expect(response['data']['addCitations']).to be_a(Array)
      expect(response['data']['addCitations'].first).to be_a(Hash)
      expect(response['data']['addCitations'].first.keys).to eq(
        %w[xCoordinate yCoordinate visible work]
      )
      expect(response['data']['addCitations'].first['xCoordinate']).to be_a(
        Integer
      )
      expect(response['data']['addCitations'].first['yCoordinate']).to be_a(
        Integer
      )
      expect(response['data']['addCitations'].first['visible']).to eq(true)
      expect(response['data']['addCitations'].first['work']).to be_a(Hash)
      expect(response['data']['addCitations'].first['work'].keys).to eq(
        ['openalexId']
      )
      expect(
        response['data']['addCitations'].first['work']['openalexId']
      ).to be_a(String)
    end
  end
end
