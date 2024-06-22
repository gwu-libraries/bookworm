# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_investigation, mutation: Mutations::CreateInvestigation

    field :add_root_work, mutation: Mutations::AddRootWork

    field :add_cites, mutation: Mutations::AddCites
  end
end
