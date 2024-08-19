# frozen_string_literal: true

module Mutations
  class SignOut < Mutations::BaseMutation
    field :user, Types::UserType, null: false

    def resolve
      user = context[:current_user]
      if user.present?
        success = user.reset_authentication_token!

        MutationResult.call(
          obj: {
            object: user
          },
          success: success,
          errors: user.errors
        )
      else
        GraphQL::ExecutionError.new('User not signed in')
      end
    end
  end
end
