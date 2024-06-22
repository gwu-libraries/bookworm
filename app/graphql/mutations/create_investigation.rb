# frozen_string_literal: true

module Mutations
  class CreateInvestigation < BaseMutation
    argument :name, String, required: true
    argument :user_id, Integer, required: true

    type Types::InvestigationType

    def resolve(user_id:, **attributes)
      user = User.find(user_id)
      investigation = user.investigations.create!(attributes)

      if investigation.save
        {
          investigation: investigation,
          errors: []
        }
      else
        {
          investigation: null,
          errors: investigation.errors.full_messages
        }
      end
    end
  end
end
