require 'rails_helper'

RSpec.describe 'Institution query', type: :request do
  before :all do
    @institution = FactoryBot.create(:institution)

    @authors = []
    5.times { @authors << FactoryBot.create(:author) }

    @works = []
    5.times { @works << FactoryBot.create(:work) }

    @authors.each do |a|
      WorksAuthorship.create(
        work_openalex_id: @works.sample.work_openalex_id,
        author_openalex_id: a.author_openalex_id,
        institution_openalex_id: @institution.institution_openalex_id
      )
    end

    @associated_institutions = []
    5.times do
      i = FactoryBot.create(:institution)

      InstitutionsAssociatedInstitutions.create(
        institution_openalex_id: @institution.institution_openalex_id,
        associated_institution_openalex_id: i.institution_openalex_id,
        relationship: %w[funder parent/child].sample
      )
    end

    @institution_by_name_query = <<-GRAPHQL
      query($name: String!) {
        institutionByName(name: $name) {
          id
          institutionOpenalexId
          ror
          displayName
          countryCode
          institutionType
          homepageUrl
          imageUrl
          imageThumbnailUrl
          worksCount
          citedByCount
          authors {
            id
          }
          wikidata
          wikipedia
          mag
          grid
          city
          region
          country
          latitude
          longitude
          associatedInstitutions {
            id
          }
        }
      }
    GRAPHQL

    @institution_by_ror_query = <<-GRAPHQL
      query($ror: String!) {
        institutionByRor(ror: $ror) {
          id
          displayName
        }
      }
    GRAPHQL

    @institution_by_openalex_id_query = <<-GRAPHQL
      query($institutionOpenalexId: String!) {
        institutionByOpenalexId(institutionOpenalexId: $institutionOpenalexId) {
          id
          displayName
        }
      }
    GRAPHQL
  end

  it 'retrieves an institution by name' do
    result =
      BookWormSchema.execute(
        @institution_by_name_query,
        variables: {
          name: @institution.display_name
        }
      )

    expect(result['data']['institutionByName']).to be_a(Hash)

    expect(result['data']['institutionByName'].keys).to eq(
      %w[
        id
        institutionOpenalexId
        ror
        displayName
        countryCode
        institutionType
        homepageUrl
        imageUrl
        imageThumbnailUrl
        worksCount
        citedByCount
        authors
        wikidata
        wikipedia
        mag
        grid
        city
        region
        country
        latitude
        longitude
        associatedInstitutions
      ]
    )

    expect(result['data']['institutionByName']['authors'].count).to eq(5)

    expect(
      result['data']['institutionByName']['associatedInstitutions'].count
    ).to eq(5)
  end

  it 'can find an institution by ROR with full url format' do
    result =
      BookWormSchema.execute(
        @institution_by_ror_query,
        variables: {
          ror: @institution.ror
        }
      )

    expect(result['data']['institutionByRor']['id']).to eq(@institution.id.to_s)
  end

  it 'can find an institution by Openalex ID with full url format' do
    result =
      BookWormSchema.execute(
        @institution_by_openalex_id_query,
        variables: {
          institutionOpenalexId:
            "https://openalex.org/#{@institution.institution_openalex_id}"
        }
      )

    expect(result['data']['institutionByOpenalexId']['id']).to eq(
      @institution.id.to_s
    )
  end

  it 'can find an institution by Openalex ID with non url format' do
    result =
      BookWormSchema.execute(
        @institution_by_openalex_id_query,
        variables: {
          institutionOpenalexId: @institution.institution_openalex_id
        }
      )

    expect(result['data']['institutionByOpenalexId']['id']).to eq(
      @institution.id.to_s
    )
  end

  it 'can find an institution by ROR with valid non-url format' do
    result =
      BookWormSchema.execute(
        @institution_by_ror_query,
        variables: {
          ror: @institution.ror[16..] #strips the url portion from the generated ROR
        }
      )

    expect(result['data']['institutionByRor']['id']).to eq(@institution.id.to_s)
  end

  it 'raises an error when receiving invalid format for ROR' do
    result =
      BookWormSchema.execute(
        @institution_by_ror_query,
        variables: {
          ror: 'abcde' #strips the url portion from the generated ROR
        }
      )

    expect(result.to_h).to be_a(Hash)
    expect(result.keys).to eq(%w[errors data])
    expect(result['errors']).to be_a(Array)
    expect(result['errors'].first).to be_a(Hash)
    expect(result['errors'].first.keys).to eq(%w[message locations path])
    expect(result['errors'].first['message']).to eq(
      'Invalid input: institutionByRor queries must have ROR in either https://ror.org/123456789 or 123456789 format (exactly nine identifying characters)'
    )
  end

  it 'raises an error when receiving invalid format for openalex ID' do
    result =
      BookWormSchema.execute(
        @institution_by_openalex_id_query,
        variables: {
          institutionOpenalexId: 'abcde'
        }
      )

    expect(result.to_h).to be_a(Hash)
    expect(result.keys).to eq(%w[errors data])
    expect(result['errors']).to be_a(Array)
    expect(result['errors'].first).to be_a(Hash)
    expect(result['errors'].first.keys).to eq(%w[message locations path])
    expect(result['errors'].first['message']).to eq(
      'Invalid input: institutionByOpenalexId queries must have OpenAlex ID in either https://openalex.org/i123456789 or i123456789 format'
    )
  end
end
