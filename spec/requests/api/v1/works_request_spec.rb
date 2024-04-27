require 'rails_helper'

RSpec.describe 'works API' do

  it 'can return one work by ID' do
    work = FactoryBot.create(:work)

    get api_v1_work_path(work.id)

    expect(response).to be_successful

    work_response = JSON.parse(response.body, symbolize_names: true)

    expect(work_response).to have_key(:id)
    expect(work_response[:id]).to eq(work.id)
    expect(work_response).to have_key(:doi)
    expect(work_response[:doi]).to eq(work.doi)
    expect(work_response).to have_key(:title)
    expect(work_response[:title]).to eq(work.title)
  end

  it 'can create a new work' do
    headers = {"CONTENT_TYPE" => "application/json"}

    work_params = {
      title: "A Super Cool Work",
      doi: "10.1111/2222222"
    }

    post api_v1_works_path, headers: headers, params: JSON.generate(work: work_params)

    expect(response).to be_successful
    response_data = JSON.parse(response.body, symbolize_names: true)[:data]

    new_work = Work.last
    
    expect(response_data[:id]).to eq(new_work.id)
    expect(response_data[:title]).to eq(new_work.title)
    expect(response_data[:doi]).to eq(new_work.doi)
  end

end