require 'rails_helper'

RSpec.describe SemanticScholarWork do
  it 'exists' do
    data = { paperId: '22d840026482e82dce65c5d0f91eb72b7b7bba1e',
             externalIds: { MAG: '2792655768', DOI: '10.1016/J.COMPOSITESB.2018.01.027', CorpusId: 139_236_155 },
             corpusId: 139_236_155,
             publicationVenue: nil,
             url: 'https://www.semanticscholar.org/paper/22d840026482e82dce65c5d0f91eb72b7b7bba1e',
             title: 'Review of current trends in research and applications of sandwich structures',
             venue: 'Composites Part B: Engineering',
             year: 2018,
             referenceCount: 364,
             citationCount: 502,
             influentialCitationCount: 5,
             isOpenAccess: true,
             openAccessPdf: { url: 'http://manuscript.elsevier.com/S1359836817339781/pdf/S1359836817339781.pdf',
                              status: 'HYBRID' },
             fieldsOfStudy: ['Materials Science'],
             s2FieldsOfStudy: [{ category: 'Materials Science', source: 'external' },
                               { category: 'Engineering', source: 's2-fos-model' },
                               { category: 'Materials Science', source: 's2-fos-model' }],
             publicationTypes: ['Review'],
             publicationDate: '2018-06-01',
             journal: { name: 'Composites Part B: Engineering' },
             citationStyles: { bibtex:        "@Article{Birman2018ReviewOC,\n author = {V. Birman and G. Kardomateas},\n booktitle = {Composites Part B: Engineering},\n journal = {Composites Part B: Engineering},\n title = {Review of current trends in research and applications of sandwich structures},\n year = {2018}\n}\n" },
             authors: [{ authorId: '6990685', name: 'V. Birman' },
                       { authorId: '93583515', name: 'G. Kardomateas' }] }

    semantic_scholar_work = SemanticScholarWork.new(data)
    expect(semantic_scholar_work.paper_id).to eq('22d840026482e82dce65c5d0f91eb72b7b7bba1e')
    expect(semantic_scholar_work.title).to eq('Review of current trends in research and applications of sandwich structures')
    expect(semantic_scholar_work.doi).to eq('10.1016/J.COMPOSITESB.2018.01.027')
    expect(semantic_scholar_work.reference_count).to eq(364)
    expect(semantic_scholar_work.citation_count).to eq(502)
  end
end
