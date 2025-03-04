require 'rails_helper'

RSpec.describe 'Author query', type: :request do
  before :all do
    @author = FactoryBot.create(:author)
    @institution_1 = FactoryBot.create(:institution)
    @institution_2 = FactoryBot.create(:institution)

    @works = []
    2.times do
      work = FactoryBot.create(:article)
      WorksAuthorship.create(
        work_openalex_id: work.work_openalex_id,
        author_openalex_id: @author.author_openalex_id,
        institution_openalex_id: @institution_1.institution_openalex_id
      )
      @works << work
    end

    2.times do
      work = FactoryBot.create(:dataset)
      WorksAuthorship.create(
        work_openalex_id: work.work_openalex_id,
        author_openalex_id: @author.author_openalex_id,
        institution_openalex_id: @institution_2.institution_openalex_id
      )
      @works << work
    end

    @basic_query_string = <<-GRAPHQL
      query($orcid: String!) {
        authorByOrcid(orcid: $orcid) {
          id
          authorOpenalexId
          orcid
          displayName
          worksCount
          citedByCount
          lastKnownInstitution
        }
      }
    GRAPHQL

    @query_with_works = <<-GRAPHQL
      query($orcid: String!) {
        authorByOrcid(orcid: $orcid) {
          id
          authorOpenalexId
          orcid
          displayName
          worksCount
          citedByCount
          lastKnownInstitution
          works {
            id
            title
          }
          articles {
            id
            title
          }
          datasets {
            id
            title
          }
        }
      }
    GRAPHQL

    @query_with_ids = <<-GRAPHQL
      query($orcid: String!) {
        authorByOrcid(orcid: $orcid) {
          id
          authorOpenalexId
          orcid
          displayName
          worksCount
          citedByCount
          lastKnownInstitution
          scopus
          wikipedia
          mag
        }
      }
    GRAPHQL

    @query_with_institutions = <<-GRAPHQL
      query($orcid: String!) {
        authorByOrcid(orcid: $orcid) {
          id
          authorOpenalexId
          orcid
          displayName
          worksCount
          citedByCount
          lastKnownInstitution
          institutions {
            id
          }
        }
      }
    GRAPHQL
  end

  it 'retrieves an author object by orcid without URL format' do
    orcid = '0000-0000-0000-0001'
    result =
      BookWormSchema.execute(@basic_query_string, variables: { orcid: orcid })

    expect(result.to_h).to be_a(Hash)
    expect(result.keys).to eq(['data'])

    expect(result['data']).to be_a(Hash)
    expect(result['data'].keys).to eq(['authorByOrcid'])
    expect(result['data']['authorByOrcid']['id']).to eq(@author.id.to_s)
    expect(result['data']['authorByOrcid']['authorOpenalexId']).to eq(
      @author.author_openalex_id
    )
    expect(result['data']['authorByOrcid']['orcid']).to eq(@author.orcid)
    expect(result['data']['authorByOrcid']['displayName']).to eq(
      @author.display_name
    )
    expect(result['data']['authorByOrcid']['worksCount']).to eq(
      @author.works_count
    )
    expect(result['data']['authorByOrcid']['citedByCount']).to eq(
      @author.cited_by_count
    )
    expect(result['data']['authorByOrcid']['lastKnownInstitution']).to eq(
      @author.last_known_institution
    )
  end

  it 'retrieves an author object by orcid with URL format' do
    orcid = 'https://orcid.org/0000-0000-0000-0001'
    result =
      BookWormSchema.execute(@basic_query_string, variables: { orcid: orcid })

    expect(result.to_h).to be_a(Hash)
    expect(result.keys).to eq(['data'])

    expect(result['data']).to be_a(Hash)
    expect(result['data'].keys).to eq(['authorByOrcid'])
    expect(result['data']['authorByOrcid']['id']).to eq(@author.id.to_s)
    expect(result['data']['authorByOrcid']['authorOpenalexId']).to eq(
      @author.author_openalex_id
    )
    expect(result['data']['authorByOrcid']['orcid']).to eq(@author.orcid)
    expect(result['data']['authorByOrcid']['displayName']).to eq(
      @author.display_name
    )
    expect(result['data']['authorByOrcid']['worksCount']).to eq(
      @author.works_count
    )
    expect(result['data']['authorByOrcid']['citedByCount']).to eq(
      @author.cited_by_count
    )
    expect(result['data']['authorByOrcid']['lastKnownInstitution']).to eq(
      @author.last_known_institution
    )
  end

  it 'returns an error if orcid is in an invalid format' do
    orcid = '0000000000000001'
    result =
      BookWormSchema.execute(@basic_query_string, variables: { orcid: orcid })

    expect(result.to_h).to be_a(Hash)
    expect(result.keys).to eq(%w[errors data])
    expect(result['errors']).to be_a(Array)
    expect(result['errors'].first).to be_a(Hash)
    expect(result['errors'].first.keys).to eq(%w[message locations path])
    expect(result['errors'].first['message']).to eq(
      'Invalid input: authorByOrcid queries must have orcid in either https://orcid.org/0000-0000-0000-0001 or 0000-0000-0000-0001 format'
    )

    expect(result['data']).to be_a(Hash)
    expect(result['data'].keys).to eq(['authorByOrcid'])
    expect(result['data']['authorByOrcid']).to eq(nil)
  end

  it 'can return associated works' do
    orcid = 'https://orcid.org/0000-0000-0000-0001'

    result =
      BookWormSchema.execute(@query_with_works, variables: { orcid: orcid })

    expect(result['data']['authorByOrcid']['works']).to be_a(Array)

    expect(result['data']['authorByOrcid']['works'].count).to eq(4)

    result['data']['authorByOrcid']['works'].each do |w|
      expect(w.keys).to eq(%w[id title])
      expect(w['id']).to be_a(String)
      expect(w['title']).to be_a(String)
    end
  end

  it 'can return just associated articles' do
    orcid = 'https://orcid.org/0000-0000-0000-0001'

    result =
      BookWormSchema.execute(@query_with_works, variables: { orcid: orcid })

    expect(result['data']['authorByOrcid']['articles']).to be_a(Array)

    expect(result['data']['authorByOrcid']['articles'].count).to eq(2)

    result['data']['authorByOrcid']['articles'].each do |w|
      expect(w.keys).to eq(%w[id title])
      expect(w['id']).to be_a(String)
      expect(w['title']).to be_a(String)
    end
  end

  it 'can return just associated datasets' do
    orcid = 'https://orcid.org/0000-0000-0000-0001'

    result =
      BookWormSchema.execute(@query_with_ids, variables: { orcid: orcid })

    expect(result['data']['authorByOrcid']['scopus']).to eq(
      @author.authors_ids.scopus
    )
    expect(result['data']['authorByOrcid']['wikipedia']).to eq(
      @author.authors_ids.wikipedia
    )
    expect(result['data']['authorByOrcid']['mag']).to eq(
      @author.authors_ids.mag
    )
  end

  it 'can return associated institutions' do
    orcid = 'https://orcid.org/0000-0000-0000-0001'

    result =
      BookWormSchema.execute(
        @query_with_institutions,
        variables: {
          orcid: orcid
        }
      )

    expect(result['data']['authorByOrcid']['institutions']).to be_a(Array)

    expect(result['data']['authorByOrcid']['institutions'].count).to eq(2)

    result['data']['authorByOrcid']['institutions'].each do |i|
      expect(i).to be_a(Hash)
    end
  end
end
