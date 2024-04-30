# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SemanticScholarFacade do
  it 'returns a paper details by doi', :vcr do
    example_doi = '10.1016/J.COMPOSITESB.2018.01.027'

    data = SemanticScholarFacade.get_paper_details(example_doi)

    expect(data.first).to be_a(SemanticScholarWork)
  end
end
