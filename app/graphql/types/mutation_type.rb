# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :register_user, mutation: Mutations::RegisterUser
    field :sign_in, mutation: Mutations::SignIn
    # field :sign_out, mutation: Mutations::SignOut

    field :create_investigation, mutation: Mutations::CreateInvestigation

    field :add_root_work, mutation: Mutations::AddRootWork

    field :add_references, mutation: Mutations::AddReferences

    field :add_citations, mutation: Mutations::AddCitations

    field :add_author, mutation: Mutations::AddAuthor

    field :create_note, mutation: Mutations::CreateNote
    field :delete_note, mutation: Mutations::DeleteNote
  end
end
