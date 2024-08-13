# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OpenalexFacade do
  it 'can return an OpenalexWork object by DOI', :vcr do
    doi = '10.1145/3174781.3174785'

    work = OpenalexFacade.get_paper_details(doi)

    expect(work).to be_a(OpenalexWork)

    expect(work.authors).to be_a(Array)
    expect(work.authors.first).to be_a(Hash)
    expect(work.authors.first.keys).to eq(%i[name orcid openalex_id])
    expect(work.cited_by_count).to be_a(Integer)
    expect(work.created_date).to be_a(String)
    expect(work.datasets).to be_a(Array)
    expect(work.doi).to be_a(String)
    expect(work.grants).to be_a(Array)
    expect(work.is_open_access).to eq(true)
    expect(work.keywords).to be_a(Array)
    expect(work.language).to be_a(String)
    expect(work.open_access_url).to be_a(String)
    expect(work.openalex_id).to be_a(String)
    expect(work.publication_year).to be_a(Integer)
    expect(work.referenced_works_count).to be_a(Integer)
    expect(work.referenced_works_openalex_ids).to be_a(Array)
    expect(work.title).to be_a(String)
    expect(work.topics).to be_a(Array)
    expect(work.type).to be_a(String)
  end

  it 'returns an array of OpenAlex reference objects', :vcr do
    openalex_id = 'W2785752813'

    references = OpenalexFacade.get_paper_references(openalex_id)

    expect(references).to be_a(Array)
    expect(references.first).to be_a(OpenalexReference)
  end

  it 'returns an array of OpenAlex citation objects', :vcr do
    openalex_id = 'W2785752813'

    references = OpenalexFacade.get_paper_citations(openalex_id)

    expect(references).to be_a(Array)
    expect(references.first).to be_a(OpenalexCitation)
  end

  it 'returns an OpenAlex author object', :vcr do
    openalex_id = 'A5023888391'

    author = OpenalexFacade.get_author_details(openalex_id)

    expect(author).to be_a(OpenalexAuthor)

    expect(author.affiliations).to be_a(Array)
    expect(author.cited_by_count).to be_a(Integer)
    expect(author.display_name).to be_a(String)
    expect(author.openalex_id).to be_a(String)
    expect(author.orcid).to be_a(String)
    expect(author.works_count).to be_a(Integer)
  end

  it 'returns an array of an authors works', :vcr do
    openalex_id = 'A5023888391'

    works = OpenalexFacade.get_author_works(openalex_id)

    expect(works).to be_a(Array)

    expect(works.first).to be_a(OpenalexWork)
  end
end
