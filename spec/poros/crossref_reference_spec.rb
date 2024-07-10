# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CrossrefReference do
  it 'exists' do
    data = {
      key: '10.1016/j.compositesb.2018.01.027_bib1',
      'series-title': 'Sandwich construction',
      author: 'Plantema',
      year: '1966'
    }

    crossref_citation = CrossrefReference.new(data)

    expect(crossref_citation).to be_a(CrossrefReference)
  end
end
