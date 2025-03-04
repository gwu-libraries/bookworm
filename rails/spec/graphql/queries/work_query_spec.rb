require 'rails_helper'

RSpec.describe 'Work query', type: :request do
  before :all do
    @work = FactoryBot.create(:article)

    @institutions = []
    5.times { @institutions << FactoryBot.create(:institution) }

    @authors = []
    5.times { @authors << FactoryBot.create(:author) }

    @works_authorships = []
    @authors.each do |a|
      WorksAuthorship.create(
        work_openalex_id: @work.work_openalex_id,
        author_openalex_id: a.author_openalex_id,
        institution_openalex_id: @institutions.sample.institution_openalex_id
      )
    end

    @topics = []
    5.times { @topics << FactoryBot.create(:topic) }

    @topics.each do |t|
      WorksTopic.create(
        work_openalex_id: @work.work_openalex_id,
        topic_openalex_id: t.topic_openalex_id
      )
    end

    @referenced_works = []
    2.times { @referenced_works << FactoryBot.create(:article) }
    2.times { @referenced_works << FactoryBot.create(:dataset) }

    @referenced_works.each do |rw|
      WorksReferencedWorks.create(
        work_openalex_id: @work.work_openalex_id,
        referenced_work_openalex_id: rw.work_openalex_id
      )
    end

    @referencing_works = []
    2.times { @referencing_works << FactoryBot.create(:article) }
    2.times { @referencing_works << FactoryBot.create(:dataset) }

    @referencing_works.each do |rw|
      WorksReferencedWorks.create(
        work_openalex_id: rw.work_openalex_id,
        referenced_work_openalex_id: @work.work_openalex_id
      )
    end

    @work_by_doi_query = <<-GRAPHQL
      query($doi: String!) {
        workByDoi(doi: $doi) {
          id
          workOpenalexId
          doi
          title
          displayName
          publicationYear
          publicationDate
          workType
          citedByCount
          isRetracted
          isParatext
          abstractInvertedIndex
          language
        }
      }
    GRAPHQL

    @work_by_doi_query_with_associations = <<-GRAPHQL
      query($doi: String!) {
        workByDoi(doi: $doi) {
          id
          authors {
            id
          }
          institutions {
            id
          }
          referencedWorks {
            id
          }
          referencedArticles {
            id
          }
          referencingWorks {
            id
          }
          referencingArticles {
            id
          }
          topics {
            id
          }
        }
      }
    GRAPHQL

    @work_by_doi_query_with_id_and_biblio = <<-GRAPHQL
      query($doi: String!) {
        workByDoi(doi: $doi) {
          id
          isOa
          oaStatus
          oaUrl
          volume
          issue
          firstPage
          lastPage
          pmid
          pmcid
          landingPageUrl
          pdfUrl
          license
          version
          anyRepositoryHasFulltext
        }
      }
    GRAPHQL
  end

  it 'retrieves a work by doi with full url format' do
    doi = 'https://doi.org/1'
    result = BookWormSchema.execute(@work_by_doi_query, variables: { doi: doi })

    expect(result['data']).to be_a(Hash)
    expect(result['data']['workByDoi']).to be_a(Hash)
    expect(result['data']['workByDoi'].keys).to eq(
      %w[
        id
        workOpenalexId
        doi
        title
        displayName
        publicationYear
        publicationDate
        workType
        citedByCount
        isRetracted
        isParatext
        abstractInvertedIndex
        language
      ]
    )
  end

  it 'retrieves a work by doi not including url format' do
    doi = '1'
    result = BookWormSchema.execute(@work_by_doi_query, variables: { doi: doi })

    expect(result['data']).to be_a(Hash)
    expect(result['data']['workByDoi']).to be_a(Hash)
    expect(result['data']['workByDoi'].keys).to eq(
      %w[
        id
        workOpenalexId
        doi
        title
        displayName
        publicationYear
        publicationDate
        workType
        citedByCount
        isRetracted
        isParatext
        abstractInvertedIndex
        language
      ]
    )
  end

  it 'retrieves a work with author associations' do
    result =
      BookWormSchema.execute(
        @work_by_doi_query_with_associations,
        variables: {
          doi: @work.doi
        }
      )

    expect(result['data']).to be_a(Hash)
    expect(result['data']['workByDoi']['authors']).to be_a(Array)
    expect(result['data']['workByDoi']['authors'].count).to eq(5)
  end

  it 'retrieves a work with institution associations' do
    result =
      BookWormSchema.execute(
        @work_by_doi_query_with_associations,
        variables: {
          doi: @work.doi
        }
      )

    expect(result['data']['workByDoi']['institutions']).to be_a(Array)
    expect(result['data']['workByDoi']['institutions'].count).to eq(5)
  end

  it 'retrieves a work with referenced works associations' do
    result =
      BookWormSchema.execute(
        @work_by_doi_query_with_associations,
        variables: {
          doi: @work.doi
        }
      )

    expect(result['data']['workByDoi']['referencedWorks']).to be_a(Array)
    expect(result['data']['workByDoi']['referencedWorks'].count).to eq(4)
  end

  it 'retrieves a work with referenced articles associations' do
    result =
      BookWormSchema.execute(
        @work_by_doi_query_with_associations,
        variables: {
          doi: @work.doi
        }
      )

    expect(result['data']['workByDoi']['referencedArticles']).to be_a(Array)
    expect(result['data']['workByDoi']['referencedArticles'].count).to eq(2)
  end

  it 'retrieves a work with referencing works associations' do
    result =
      BookWormSchema.execute(
        @work_by_doi_query_with_associations,
        variables: {
          doi: @work.doi
        }
      )

    expect(result['data']['workByDoi']['referencingWorks']).to be_a(Array)
    expect(result['data']['workByDoi']['referencingWorks'].count).to eq(4)
  end

  it 'retrieves a work with referencing articles associations' do
    result =
      BookWormSchema.execute(
        @work_by_doi_query_with_associations,
        variables: {
          doi: @work.doi
        }
      )

    expect(result['data']['workByDoi']['referencingArticles']).to be_a(Array)
    expect(result['data']['workByDoi']['referencingArticles'].count).to eq(2)
  end

  it 'retrieves a work with topic associations' do
    result =
      BookWormSchema.execute(
        @work_by_doi_query_with_associations,
        variables: {
          doi: @work.doi
        }
      )

    expect(result['data']['workByDoi']['topics']).to be_a(Array)
    expect(result['data']['workByDoi']['topics'].count).to eq(5)
  end

  it 'retrieves a work with ID and biblio information' do
    result =
      BookWormSchema.execute(
        @work_by_doi_query_with_id_and_biblio,
        variables: {
          doi: @work.doi
        }
      )

    expect(result['data']['workByDoi']['isOa']).to eq(
      @work.works_open_access.is_oa
    )
    expect(result['data']['workByDoi']['oaStatus']).to eq(
      @work.works_open_access.oa_status
    )
    expect(result['data']['workByDoi']['oaUrl']).to eq(
      @work.works_open_access.oa_url
    )
    expect(result['data']['workByDoi']['volume']).to eq(
      @work.works_biblio.volume
    )
    expect(result['data']['workByDoi']['issue']).to eq(@work.works_biblio.issue)
    expect(result['data']['workByDoi']['firstPage']).to eq(
      @work.works_biblio.first_page
    )
    expect(result['data']['workByDoi']['lastPage']).to eq(
      @work.works_biblio.last_page
    )
    expect(result['data']['workByDoi']['landingPageUrl']).to eq(
      @work.works_best_oa_location.landing_page_url
    )
    expect(result['data']['workByDoi']['pdfUrl']).to eq(
      @work.works_best_oa_location.pdf_url
    )
    expect(result['data']['workByDoi']['license']).to eq(
      @work.works_best_oa_location.license
    )
    expect(result['data']['workByDoi']['version']).to eq(
      @work.works_best_oa_location.version
    )
    expect(result['data']['workByDoi']['anyRepositoryHasFulltext']).to eq(
      @work.works_open_access.any_repository_has_fulltext
    )
    expect(result['data']['workByDoi']['pmid']).to eq(@work.works_ids.pmid)
    expect(result['data']['workByDoi']['pmcid']).to eq(@work.works_ids.pmcid)
  end
end
