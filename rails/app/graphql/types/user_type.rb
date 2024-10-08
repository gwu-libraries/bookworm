# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    implements GraphQL::Types::Relay::Node
    global_id_field :id

    field :email, String, null: false

    field :authentication_token, String, null: false

    def authentication_token
      if object[:object].gql_id != context[:current_user]&.gql_id
        raise GraphQL::UnauthorizedFieldError,
              'Unable to access authentication_token'
      end

      object[:object].authentication_token
    end
  end
end
