require 'rails_helper'

RSpec.describe "Author query", type: :request do

  before :all do
    @author = FactoryBot.create(:author)
    @institution = FactoryBot.create(:institution)
  
    @works = []
    5.times do
      work = FactoryBot.create(:work)
      WorksAuthorship.create(work_openalex_id: work.work_openalex_id,
                             author_openalex_id: @author.author_openalex_id,
                             institution_openalex_id: @institution.institution_openalex_id)
      @works << work
    end
  
    @query_string = <<-GRAPHQL
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
  end

  it 'retrieves an author object by orcid without URL format' do
    orcid = "0000-0000-0000-0001"
    result = BookWormSchema.execute(@query_string, 
                                    variables: {orcid: orcid})

    expect(result.to_h).to be_a(Hash)
    expect(result.keys).to eq(['data'])
    
    expect(result['data']).to be_a(Hash)
    expect(result['data'].keys).to eq(['authorByOrcid'])
    expect(result['data']['authorByOrcid'].keys).to eq(['id', 'authorOpenalexId', 'orcid', 'displayName', 'worksCount', 'citedByCount', 'lastKnownInstitution'])
    expect(result['data']['authorByOrcid']['id']).to eq(@author.id.to_s)
    expect(result['data']['authorByOrcid']['authorOpenalexId']).to eq(@author.author_openalex_id)
    expect(result['data']['authorByOrcid']['orcid']).to eq(@author.orcid)
    expect(result['data']['authorByOrcid']['displayName']).to eq(@author.display_name)
    expect(result['data']['authorByOrcid']['worksCount']).to eq(@author.works_count)
    expect(result['data']['authorByOrcid']['citedByCount']).to eq(@author.cited_by_count)
    expect(result['data']['authorByOrcid']['lastKnownInstitution']).to eq(@author.last_known_institution)
  end

  it 'retrieves an author object by orcid with URL format' do
    orcid = "https://orcid.org/0000-0000-0000-0001"
    result = BookWormSchema.execute(@query_string, 
                                    variables: {orcid: orcid})

    expect(result.to_h).to be_a(Hash)
    expect(result.keys).to eq(['data'])
    
    expect(result['data']).to be_a(Hash)
    expect(result['data'].keys).to eq(['authorByOrcid'])
    expect(result['data']['authorByOrcid'].keys).to eq(['id', 'authorOpenalexId', 'orcid', 'displayName', 'worksCount', 'citedByCount', 'lastKnownInstitution'])
    expect(result['data']['authorByOrcid']['id']).to eq(@author.id.to_s)
    expect(result['data']['authorByOrcid']['authorOpenalexId']).to eq(@author.author_openalex_id)
    expect(result['data']['authorByOrcid']['orcid']).to eq(@author.orcid)
    expect(result['data']['authorByOrcid']['displayName']).to eq(@author.display_name)
    expect(result['data']['authorByOrcid']['worksCount']).to eq(@author.works_count)
    expect(result['data']['authorByOrcid']['citedByCount']).to eq(@author.cited_by_count)
    expect(result['data']['authorByOrcid']['lastKnownInstitution']).to eq(@author.last_known_institution)
  end

  it 'returns an error if orcid is in an invalid format' do
    orcid = "0000000000000001"
    result = BookWormSchema.execute(@query_string, 
                                    variables: {orcid: orcid})

    expect(result.to_h).to be_a(Hash)
    expect(result.keys).to eq(["errors", "data"])
    expect(result['errors']).to be_a(Array)
    expect(result['errors'].first).to be_a(Hash)
    expect(result['errors'].first.keys).to eq(['message', 'locations', 'path'])
    expect(result['errors'].first['message']).to eq("Invalid input: authorByOrcid queries must have orcid in either https://orcid.org/0000-0000-0000-0001 or 0000-0000-0000-0001 format")
    
    expect(result['data']).to be_a(Hash)
    expect(result['data'].keys).to eq(['authorByOrcid'])
    expect(result['data']['authorByOrcid']).to eq(nil)
  end


end