# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CrossrefFacade do
  it 'returns a paper details by doi', :vcr do
    example_doi = '10.1016/J.COMPOSITESB.2018.01.027'

    data = CrossrefFacade.get_paper_details(example_doi)

    expect(data).to be_a(CrossrefWork)
  end
end