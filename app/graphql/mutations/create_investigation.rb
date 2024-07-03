# frozen_string_literal: true

module Mutations
  class CreateInvestigation < BaseMutation
    argument :name, String, required: true
    argument :user_id, Integer, required: true

    type Types::InvestigationType

    def resolve(user_id:, **attributes)
      authorize_user

      user = User.find(user_id)
      investigation = user.investigations.create!(attributes)

      MutationResult.call(
        obj: { object: investigation },
        success: investigation.persisted?,
        errors: investigation.errors.full_messages
      )

      # if investigation.save
      #   {
      #     investigation: investigation,
      #     errors: []
      #   }
      # else
      #   {
      #     investigation: null,
      #     errors: investigation.errors.full_messages
      #   }
      # end
    end
  end
end
