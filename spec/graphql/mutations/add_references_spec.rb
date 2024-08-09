# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::AddReferences, type: :request do
  def add_references_mutation
    <<~GQL
      mutation ($openalexId: String!, $investigationId: String!) {
        addReferences(
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

  def investigation_query
    <<~GQL
        query UseInvestigationGraph($id: ID!) {
    investigation(id: $id) {
      workNodes {
        id
        work {
          id
          citations {
          id
          }
          references {
          id
          }
        }
      }
      edges {
        id
        visible
        connection {
          id
          reference {
            title
            id
          }
          citation {
            title
            id
          }
        }
      }
    }
  }
    GQL
  end

  context '.resolve' do
    it "adds a work's references to an investigation", :vcr do
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
          add_references_mutation,
          variables: {
            openalexId: work_node_openalex_id,
            investigationId: investigation_1.id.to_s
          },
          context: {
            current_user: user_1
          }
        ).to_h

      investigation_response =
        BookWormApiSchema.execute(
          investigation_query,
          variables: {
            id: investigation_1.id
          },
          context: {
            current_user: user_1
          }
        ).to_h

      require 'pry'
      binding.pry

      expect(response).to be_a(Hash)
      expect(response.keys).to eq(['data'])
      expect(response['data'].keys).to eq(['addReferences'])
      expect(response['data']['addReferences']).to be_a(Array)
      expect(response['data']['addReferences'].first).to be_a(Hash)
      expect(response['data']['addReferences'].first.keys).to eq(
        %w[xCoordinate yCoordinate visible work]
      )
      expect(response['data']['addReferences'].first['xCoordinate']).to be_a(
        Integer
      )
      expect(response['data']['addReferences'].first['yCoordinate']).to be_a(
        Integer
      )
      expect(response['data']['addReferences'].first['visible']).to eq(true)
      expect(response['data']['addReferences'].first['work']).to be_a(Hash)
      expect(response['data']['addReferences'].first['work'].keys).to eq(
        ['openalexId']
      )
      expect(
        response['data']['addReferences'].first['work']['openalexId']
      ).to be_a(String)
    end
  end
end
