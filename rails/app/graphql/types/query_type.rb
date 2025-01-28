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

    # need to index institutions by openalex id
    # field :institution_by_openalex_id,
    #       Types::InstitutionType,
    #       null: true,
    #       description: 'Fetches an institution by institution_openalex_id' do
    #   argument :institution_openalex_id, String, required: true
    # end
    # def institution_by_openalex_id(institution_openalex_id:)
    #   Institution.find_by(institution_openalex_id: institution_openalex_id)
    # end

    field :institution_by_ror,
          Types::InstitutionType,
          null: true,
          description: 'Fetches an institution by ROR' do
      argument :ror, String, required: true
  end
    def institution_by_ror(ror:)
      Institution.find_by(ror: ror)
    end

    field :institution_by_name,
          Types::InstitutionType,
          null: true,
          description: 'Fetches an institution by name' do
      argument :name, String, required: true
    end
    def institution_by_name(name:)
      Institution.find_by(display_name: name)
    end

    # author entry points

    field :author_by_openalex_id,
          Types::AuthorType,
          null: true,
          description: 'Fetch author by OpenAlex ID' do
      argument :author_openalex_id, String, required: true
    end
    def author_by_openalex_id(author_openalex_id:)
      Author.find_by(author_openalex_id: author_openalex_id)
    end

    field :author_by_orcid,
          Types::AuthorType,
          null: true,
          description: 'Fetch author by OpenAlex ID' do
      argument :orcid, String, required: true
    end
    def author_by_orcid(orcid:)
      # do some error handling for invalid entries
      if "https://orcid.org/".in? orcid
        Author.find_by(orcid: orcid)
      else
        Author.find_by(orcid: "https://orcid.org/" + orcid)
      end
    end

    # work entry points

    field :work_by_openalex_id,
          Types::WorkType,
          null: true,
          description: 'Fetch work by OpenAlex ID' do
      argument :work_openalex_id, String, required: true
    end
    def work_by_openalex_id(work_openalex_id:)
      Work.find_by(work_openalex_id: work_openalex_id)
    end

    field :work_by_doi,
          Types::WorkType,
          null: true,
          description: 'Fetch work by DOI' do
      argument :doi, String, required: true
    end
    def work_by_doi(doi:)
      Work.find_by(doi: doi)
    end
  end
end
