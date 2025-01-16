# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::CreateInvestigation, type: :request do
  def create_investigation_mutation
    <<~GQL
      mutation ($name: String!) {
        createInvestigation(input: { name: $name }) {
          id
          name
        }
      }
    GQL
  end

  describe '.resolve' do
    it 'can create a new investigation' do
      user_1 = FactoryBot.create(:user)

      response =
        BookWormSchema.execute(
          create_investigation_mutation,
          variables: {
            name: 'My new investigation'
          },
          context: {
            current_user: user_1
          }
        ).to_h

      expect(response).to be_a(Hash)
      expect(response['data'].keys).to eq(%w[createInvestigation])
      expect(response['data']['createInvestigation'].keys).to eq(%w[id name])
      expect(response['data']['createInvestigation']['name']).to eq(
        'My new investigation'
      )
    end
  end
end
