# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OpenalexService do
  it 'returns details about a work', :vcr do
    doi = '10.1145/3174781.3174785'

    response = OpenalexService.get_paper_details(doi)

    expect(response).to be_a(Hash)
    expect(response).to have_key(:id)
    expect(response).to have_key(:doi)
    expect(response).to have_key(:title)
    expect(response).to have_key(:publication_year)
    expect(response).to have_key(:publication_date)
    expect(response).to have_key(:ids)
    expect(response).to have_key(:language)
    expect(response).to have_key(:primary_location)
    expect(response).to have_key(:type)
  end
end
