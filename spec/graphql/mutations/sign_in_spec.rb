# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::SignIn, type: :request do
  def sign_in_mutation
    <<~GQL
      mutation ($email: String!, $password: String!) {
        signIn(input: { email: $email, password: $password }) {
          id
          authenticationToken
        }
      }
    GQL
  end

  before :all do
    @user_1 = FactoryBot.create(:user)
  end

  describe '.resolve' do
    it 'signs in a user with correct email and password' do
      response =
        BookWormApiSchema.execute(
          sign_in_mutation,
          variables: {
            email: @user_1.email,
            password: @user_1.password
          }
        ).to_h

      expect(response).to be_a(Hash)
      expect(response.keys).to eq(['data'])
      expect(response['data']['signIn']).to be_a(Hash)
      expect(response['data']['signIn'].keys).to eq(%w[id authenticationToken])

      expect(response['data']['signIn']['authenticationToken']).to eq(
        @user_1.authentication_token
      )
    end
  end
end
