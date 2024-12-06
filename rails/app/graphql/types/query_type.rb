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

    field :institution,
          Types::InstitutionType,
          null: true,
          description: 'Fetches an institution by institution_openalex_id' do
      argument :institution_openalex_id, String, required: true
    end
    def institution(institution_openalex_id:)
      Institution.find_by(institution_openalex_id: institution_openalex_id)
    end

    field :author,
          Types::AuthorType,
          null: true,
          description: 'Fetch author by ID' do
      argument :author_openalex_id, String, required: true
    end
    def author(author_openalex_id:)
      Author.find_by(author_openalex_id: author_openalex_id)
    end

    field :work, Types::WorkType, null: true, description: 'Fetch work by ID' do
      argument :work_openalex_id, String, required: true
    end
    def work(work_openalex_id:)
      Work.find_by(work_openalex_id: work_openalex_id)
    end
  end
end
