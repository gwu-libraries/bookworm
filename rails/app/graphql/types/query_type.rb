# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node,
          Types::NodeType,
          null: true,
          description: 'Fetches an object given its ID.' do
      argument :id, ID, required: true, description: 'ID of the object.'
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes,
          [Types::NodeType, { null: true }],
          null: true,
          description: 'Fetches a list of objects given a list of IDs.' do
      argument :ids, [ID], required: true, description: 'IDs of the objects.'
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :institutions,
          [Types::InstitutionType],
          null: true,
          description: 'Fetch all institutions'
    def institutions
      Institution.all
    end

    field :institution,
          Types::InstitutionType,
          null: true,
          description: 'Fetches an institution by ID' do
        argument :id, ID, required: true
    end
    def institution(id:)
      Institution.find(id)
    end

    field :authors,
          [Types::AuthorType],
          null: true,
          description: 'Fetch all authors'
    def authors
      Author.all
    end

    field :author,
          Types::AuthorType,
          null: true,
          description: 'Fetch author by ID' do
        argument :id, ID, required: true
    end
    def author(id:)
      Author.find(id)
    end
  end
end
