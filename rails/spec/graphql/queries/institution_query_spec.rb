require 'rails_helper'

RSpec.describe 'Institution query', type: :request do
  before :all do
    @institution = FactoryBot.create(:institution)

    @authors = []
    @works = []
    5.times do
      author = FactoryBot.create(:author)
      work = FactoryBot.create(:work)

      WorksAuthorship.create(
        work_openalex_id: work.work_openalex_id,
        author_openalex_id: author.author_openalex_id,
        institution_openalex_id: @institution.institution_openalex_id
      )

      @authors << author
      @works << work
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
end
