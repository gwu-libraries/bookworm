# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::AddAuthorWorks, type: :request do
  def add_author_works_mutation
    <<~GQL
      mutation ($openalexId: String!, $investigationId: Int!) {
        addAuthorWorks(
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
          add_author_works_mutation,
          variables: {
            openalexId: 'A5023888391',
            investigationId: investigation_1.id
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
        %w[openalexId doi]
      )
      expect(response['data']['addAuthorWorks'].first['openalexId']).to be_a(
        String
      )
      expect(response['data']['addAuthorWorks'].first['doi']).to be_a(String)
    end
  end
end
