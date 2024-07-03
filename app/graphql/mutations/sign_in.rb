# frozen_string_literal: true

module Mutations
  class SignIn < Mutations::BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    field :user, Types::UserType, null: false

    def resolve(**attributes)
      user = User.find_for_database_authentication(email: attributes[:email])

      if user.present?
        if user.valid_password?(attributes[:password])
          context[:current_user] = user
          MutationResult.call(obj: {object: user}, success: true)
        else
          GraphQL::ExecutionError.new("Incorrect Email/Password")
        end
      else
        GraphQL::ExecutionError.new("User not registered on this application")
      end
    end
  end
end