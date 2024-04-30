# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CrossrefWork do
  it 'exists' do
    @demo_data = JSON.parse(File.read('spec/fixtures/crossref_work_data.json'), symbolize_names: true)

    crossref_work = CrossrefWork.new(@demo_data)

    expect(crossref_work.reference_count).to eq(363)
    expect(crossref_work.doi).to eq('10.1016/j.compositesb.2018.01.027')
    expect(crossref_work.title).to eq('Review of current trends in research and applications of sandwich structures')
  end
end
