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
end
