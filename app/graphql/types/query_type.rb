# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: 'Fetches an object given its ID.' do
      argument :id, ID, required: true, description: 'ID of the object.'
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, { null: true }], null: true,
                                                     description: 'Fetches a list of objects given a list of IDs.' do
      argument :ids, [ID], required: true, description: 'IDs of the objects.'
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :works, [Types::WorkType], null: true,
                                     description: 'Fetches all the works'
    def works
      Work.all
    end

    field :work, Types::WorkType, null: true,
                                  description: 'Fetches a work by ID' do
      argument :id, ID, required: true
    end
    def work(id:)
      Work.find_by(id: id)
    end

    field :investigations, [Types::InvestigationType], null: true,
                                                       description: 'Fetches all investigations'
    def investigations
      if context[:current_user].present?
        Investigation.where(user_id: context[:current_user].id)
      else
        []
      end
        
    end

    field :investigation, Types::InvestigationType, null: true,
                                                    description: 'Fetches an Investigation by ID' do
      argument :id, ID, required: true
    end
    def investigation(id:)
      Investigation.find_by(id: id)
    end
  end
end
