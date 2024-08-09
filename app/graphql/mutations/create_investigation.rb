# frozen_string_literal: true

module Mutations
  class CreateInvestigation < BaseMutation
    argument :name, String, required: true

    type Types::InvestigationType

    def resolve(**attributes)
      authorize_user

      user = context[:current_user]

      investigation =
        user.investigations.create!(attributes.merge({ user_id: user.id }))

      investigation.persisted? ? investigation : 'uhoh'
    end
  end
end
