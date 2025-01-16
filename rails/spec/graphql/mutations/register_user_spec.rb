# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::RegisterUser, type: :request do
  def register_user_mutation
    <<~GQL
      mutation ($email: String!, $password: String!) {
        registerUser(input: { email: $email, password: $password }) {
          id
          authenticationToken
        }
      }
    GQL
  end

  describe '.resolve' do
    it 'can create a new user, given a valid email and password' do
      response =
        BookWormSchema.execute(
          register_user_mutation,
          variables: {
            email: 'sandwichpkitty@email.com',
            password: 'pjassword'
          }
        ).to_h

      expect(response).to be_a(Hash)
      expect(response.keys).to eq(['data'])
      expect(response['data'].keys).to eq(['registerUser'])
      expect(response['data']['registerUser'].keys).to eq(
        %w[id authenticationToken]
      )
    end

    it 'does not register a new user if email is taken' do
      user_1 =
        User.create(email: 'sandwichpkitty@email.com', password: 'pjassword')

      response =
        BookWormSchema.execute(
          register_user_mutation,
          variables: {
            email: 'sandwichpkitty@email.com',
            password: 'pjassword'
          }
        ).to_h

      expect(response.keys).to eq(%w[errors data])
      expect(response['errors'][0].keys).to eq(%w[message locations path])

      expect(response['errors'][0]['message']).to eq(
        'Invalid Attributes for User: Email has already been taken'
      )
    end

    it 'does not register a new user if email is invalid' do
      response =
        BookWormSchema.execute(
          register_user_mutation,
          variables: {
            email: 'sandwichpkitty',
            password: 'pjassword'
          }
        ).to_h

      expect(response.keys).to eq(%w[errors data])
      expect(response['errors'][0].keys).to eq(%w[message locations path])

      expect(response['errors'][0]['message']).to eq(
        'Invalid Attributes for User: Email is invalid'
      )
    end

    it 'does not register a new user if password is too short' do
      response =
        BookWormSchema.execute(
          register_user_mutation,
          variables: {
            email: 'sandwichpkitty@email.com',
            password: 'ps'
          }
        ).to_h

      expect(response.keys).to eq(%w[errors data])
      expect(response['errors'][0].keys).to eq(%w[message locations path])

      expect(response['errors'][0]['message']).to eq(
        'Invalid Attributes for User: Password is too short (minimum is 6 characters)'
      )
    end
  end
end
