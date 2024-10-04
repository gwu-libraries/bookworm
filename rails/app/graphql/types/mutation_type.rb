# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :register_user, mutation: Mutations::RegisterUser
    # field :sign_in, mutation: Mutations::SignIn
    # # field :sign_out, mutation: Mutations::SignOut

    # field :create_investigation, mutation: Mutations::CreateInvestigation

    # field :create_work_node, mutation: Mutations::CreateWorkNode
    # field :update_work_node, mutation: Mutations::UpdateWorkNode
    # field :add_references, mutation: Mutations::AddReferences
    # field :add_citations, mutation: Mutations::AddCitations

    # field :create_author_node, mutation: Mutations::CreateAuthorNode
    # field :add_author_works, mutation: Mutations::AddAuthorWorks

    # field :create_note_node, mutation: Mutations::CreateNoteNode
    # field :delete_note_node, mutation: Mutations::DeleteNoteNode
  end
end
