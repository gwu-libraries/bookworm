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

    # Institutions entry points

    field :institution_by_openalex_id,
          Types::InstitutionType,
          null: true,
          description: 'Fetches an institution by institution_openalex_id' do
      argument :institution_openalex_id, String, required: true
    end
    def institution_by_openalex_id(institution_openalex_id:)
      if Regexp.new(
           'https://openalex\\.org/[A-Za-z0-9]+',
           Regexp::IGNORECASE
         ).match institution_openalex_id
        Institution.find_by(
          institution_openalex_id: institution_openalex_id.split('/').last
        )
      elsif Regexp.new(
            'i[0-9]+',
            Regexp::IGNORECASE
          ).match institution_openalex_id
        Institution.find_by(institution_openalex_id: institution_openalex_id)
      else
        raise(
          GraphQL::ExecutionError.new(
            'Invalid input: institutionByOpenalexId queries must have OpenAlex ID in either https://openalex.org/i123456789 or i123456789 format'
          )
        )
      end
    end

    field :institution_by_ror,
          Types::InstitutionType,
          null: true,
          description: 'Fetches an institution by ROR' do
      argument :ror, String, required: true
    end
    def institution_by_ror(ror:)
      if Regexp.new(
           'https://ror\\.org/[A-Za-z0-9]+',
           Regexp::IGNORECASE
         ).match ror
        Institution.find_by(ror: ror)
      elsif Regexp.new('[A-Za-z0-9]{9}', Regexp::IGNORECASE).match ror
        Institution.find_by(ror: 'https://ror.org/' + ror)
      else
        raise(
          GraphQL::ExecutionError.new(
            'Invalid input: institutionByRor queries must have ROR in either https://ror.org/123456789 or 123456789 format (exactly nine identifying characters)'
          )
        )
      end
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
      if Regexp.new(
           'https://openalex\\.org/[A-Za-z0-9]+',
           Regexp::IGNORECASE
         ).match author_openalex_id
        Author.find_by(author_openalex_id: author_openalex_id.split('/').last)
      elsif Regexp.new('a[0-9]+', Regexp::IGNORECASE).match author_openalex_id
        Author.find_by(author_openalex_id: author_openalex_id)
      else
        raise(
          GraphQL::ExecutionError.new(
            'Invalid input: authorByOpenalexId queries must have OpenAlex ID in either https://openalex.org/a123456789 or a123456789 format'
          )
        )
      end
    end

    field :author_by_orcid,
          Types::AuthorType,
          null: true,
          description: 'Fetch author by OpenAlex ID' do
      argument :orcid, String, required: true
    end
    def author_by_orcid(orcid:)
      # handle queries with full orcid url
      if Regexp.new(
           'https://orcid\\.org/([0-9]+(-[0-9]+)+)',
           Regexp::IGNORECASE
         ).match orcid
        Author.find_by(orcid: orcid)
        # handle queries with number plus dashes
      elsif Regexp.new('([0-9]+(-[0-9]+)+)', Regexp::IGNORECASE).match orcid
        Author.find_by(orcid: 'https://orcid.org/' + orcid)
      else
        raise(
          GraphQL::ExecutionError.new(
            'Invalid input: authorByOrcid queries must have orcid in either https://orcid.org/0000-0000-0000-0001 or 0000-0000-0000-0001 format'
          )
        )
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
      if doi.include? 'https://doi.org/'
        Work.find_by(doi: doi)
      else
        Work.find_by(doi: 'https://doi.org/' + doi)
      end
    end
  end
end
