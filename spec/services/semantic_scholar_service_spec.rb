# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SemanticScholarService do
  context '#get_paper_details' do
    it 'returns details about a paper', :vcr do
      paper_id = '22d840026482e82dce65c5d0f91eb72b7b7bba1e'

      response = SemanticScholarService.get_paper_details(paper_id)

      expect(response).to be_a(Hash)

      expect(response).to have_key(:paperId)
      expect(response[:paperId]).to be_a(String)

      expect(response).to have_key(:externalIds)
      expect(response[:externalIds]).to be_a(Hash)
      expect(response[:externalIds]).to have_key(:MAG)
      expect(response[:externalIds][:MAG]).to be_a(String)
      expect(response[:externalIds]).to have_key(:DOI)
      expect(response[:externalIds][:DOI]).to be_a(String)
      expect(response[:externalIds]).to have_key(:CorpusId)
      expect(response[:externalIds][:CorpusId]).to be_a(Integer)

      expect(response).to have_key(:url)
      expect(response[:url]).to be_a(String)
      expect(response).to have_key(:title)
      expect(response[:title]).to be_a(String)
      expect(response).to have_key(:venue)
      expect(response[:venue]).to be_a(String)
      expect(response).to have_key(:year)
      expect(response[:year]).to be_a(Integer)
      expect(response).to have_key(:referenceCount)
      expect(response[:referenceCount]).to be_a(Integer)
      expect(response).to have_key(:citationCount)
      expect(response[:citationCount]).to be_a(Integer)
      expect(response).to have_key(:influentialCitationCount)
      expect(response[:influentialCitationCount]).to be_a(Integer)
      expect(response).to have_key(:isOpenAccess)
      expect(response[:isOpenAccess]).to be(true)
      expect(response).to have_key(:openAccessPdf)
      expect(response[:openAccessPdf]).to be_a(Hash)
      expect(response[:openAccessPdf]).to have_key(:url)
      expect(response[:openAccessPdf][:url]).to be_a(String)
      expect(response[:openAccessPdf]).to have_key(:status)
      expect(response[:openAccessPdf][:status]).to be_a(String)
      expect(response).to have_key(:fieldsOfStudy)
      expect(response[:fieldsOfStudy]).to be_a(Array)
      expect(response[:fieldsOfStudy].first).to be_a(String)
      expect(response).to have_key(:s2FieldsOfStudy)
      expect(response[:s2FieldsOfStudy]).to be_a(Array)
      expect(response[:s2FieldsOfStudy].first).to be_a(Hash)
      expect(response[:s2FieldsOfStudy].first).to have_key(:category)
      expect(response[:s2FieldsOfStudy].first[:category]).to be_a(String)
      expect(response[:s2FieldsOfStudy].first).to have_key(:source)
      expect(response[:s2FieldsOfStudy].first[:source]).to be_a(String)
      expect(response).to have_key(:publicationTypes)
      expect(response[:publicationTypes]).to be_a(Array)
      expect(response[:publicationTypes].first).to be_a(String)
      expect(response).to have_key(:publicationDate)
      expect(response[:publicationDate]).to be_a(String)
      expect(response).to have_key(:journal)
      expect(response[:journal]).to be_a(Hash)
      expect(response[:journal]).to have_key(:name)
      expect(response[:journal][:name]).to be_a(String)
      expect(response).to have_key(:citationStyles)
      expect(response[:citationStyles]).to be_a(Hash)
      expect(response[:citationStyles]).to have_key(:bibtex)
      expect(response[:citationStyles][:bibtex]).to be_a(String)
      expect(response).to have_key(:authors)
      expect(response[:authors]).to be_a(Array)
      expect(response[:authors].first).to have_key(:authorId)
      expect(response[:authors].first[:authorId]).to be_a(String)
      expect(response[:authors].first).to have_key(:name)
      expect(response[:authors].first[:name]).to be_a(String)
    end
  end

  context 'get_paper_citations' do
    it 'returns details about a papers citations', :vcr do
      paper_id = '22d840026482e82dce65c5d0f91eb72b7b7bba1e'

      response = SemanticScholarService.get_paper_citations(paper_id)

      expect(response).to be_a(Array)
    end
  end
end
