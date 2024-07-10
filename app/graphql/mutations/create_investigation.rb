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

      # MutationResult.call(
      #   obj: { object: investigation },
      #   success: investigation.persisted?,
      #   errors: investigation.errors.full_messages
      # )
      investigation.persisted? ? investigation : 'uhoh'
    end
  end
end
