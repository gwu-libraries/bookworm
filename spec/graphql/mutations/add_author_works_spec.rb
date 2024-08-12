# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::AddAuthorshipConnections, type: :request do
  def add_authorship_connections_mutation
    <<~GQL
      mutation ($openalexId: String!, $investigationId: Int!) {
        addAuthorshipConnections(
          input: { openalexId: $openalexId, investigationId: $investigationId }
        ) {
          openalexId
          doi
        }
      }
    GQL
  end

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

  describe '.resolve' do
    it "it adds an author's works to an investigation", :vcr do
      user_1 = FactoryBot.create(:user)

      investigation_1 = FactoryBot.create(:investigation, user_id: user_1.id)

      # creating an author node
      BookWormApiSchema.execute(
        create_author_node_mutation,
        variables: {
          openalexId: 'A5023888391',
          investigationId: investigation_1.id
        },
        context: {
          current_user: user_1
        }
      )

      response =
        BookWormApiSchema.execute(
          add_authorship_connections_mutation,
          variables: {
            openalexId: 'A5023888391',
            investigationId: investigation_1.id
          },
          context: {
            current_user: user_1
          }
        ).to_h

      expect(response).to be_a(Hash)
      expect(response['data'].keys).to eq(['addAuthorshipConnections'])
      expect(response['data']['addAuthorshipConnections']).to be_a(Array)
      expect(response['data']['addAuthorshipConnections'].first).to be_a(Hash)
      expect(response['data']['addAuthorshipConnections'].first.keys).to eq(
        %w[openalexId doi]
      )
      expect(
        response['data']['addAuthorshipConnections'].first['openalexId']
      ).to be_a(String)
      expect(response['data']['addAuthorshipConnections'].first['doi']).to be_a(
        String
      )
    end
  end
end
