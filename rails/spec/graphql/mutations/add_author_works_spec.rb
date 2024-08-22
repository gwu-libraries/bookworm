# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::AddAuthorWorks, type: :request do
  def add_author_works_mutation
    <<~GQL
      mutation ($openalexId: String!, $investigationId: String!) {
        addAuthorWorks(
          input: { openalexId: $openalexId, investigationId: $investigationId }
        ) {
          xCoordinate
          yCoordinate
          work {
            openalexId
            doi
          }
        }
      }
    GQL
  end

  def create_author_node_mutation
    <<~GQL
    mutation ($openalexId: String!, $investigationId: String!) {
      createAuthorNode(
        input: { openalexId: $openalexId, investigationId: $investigationId }
      ) {
        xCoordinate
        yCoordinate
        visible
        author {
          name
          orcid
          openalexId
        }
      }
    }
    GQL
  end

  describe '.resolve' do
    xit "it adds an author's works to an investigation", :vcr do
      user_1 = FactoryBot.create(:user)

      investigation_1 = FactoryBot.create(:investigation, user_id: user_1.id)

      # creating an author node
      author_node_response =
        BookWormApiSchema.execute(
          create_author_node_mutation,
          variables: {
            openalexId: 'A5023888391',
            investigationId: investigation_1.id.to_s
          },
          context: {
            current_user: user_1
          }
        ).to_h

      response =
        BookWormApiSchema.execute(
          add_author_works_mutation,
          variables: {
            openalexId: 'A5023888391',
            investigationId: investigation_1.id.to_s
          },
          context: {
            current_user: user_1
          }
        ).to_h

      expect(response).to be_a(Hash)
      expect(response['data'].keys).to eq(['addAuthorWorks'])
      expect(response['data']['addAuthorWorks']).to be_a(Array)
      expect(response['data']['addAuthorWorks'].first).to be_a(Hash)
      expect(response['data']['addAuthorWorks'].first.keys).to eq(
        %w[xCoordinate yCoordinate work]
      )
      expect(
        response['data']['addAuthorWorks'].first['work']['openalexId']
      ).to be_a(String)
      expect(response['data']['addAuthorWorks'].first['work']['doi']).to be_a(
        String
      )
    end
  end
end
