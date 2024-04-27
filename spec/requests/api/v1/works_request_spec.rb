require 'rails_helper'

RSpec.describe 'works API' do

  it 'can return one work by ID' do
    user = FactoryBot.create(:user)
    investigation = FactoryBot.create(:investigation, user_id: user.id)

    work = FactoryBot.create(:work, investigation_id: investigation.id)

    get api_v1_work_path(work.id)

    expect(response).to be_successful

    work_response = JSON.parse(response.body, symbolize_names: true)[:data].first

    expect(work_response).to have_key(:id)
    expect(work_response[:id]).to eq(work.id)
    expect(work_response).to have_key(:doi)
    expect(work_response[:doi]).to eq(work.doi)
    expect(work_response).to have_key(:title)
    expect(work_response[:title]).to eq(work.title)
  end

  it 'can return a list of all works' do
    user = FactoryBot.create(:user)
    investigation = FactoryBot.create(:investigation, user_id: user.id)
      work_1 = FactoryBot.create(:work, investigation_id: investigation.id)
      work_2 = FactoryBot.create(:work, investigation_id: investigation.id)
      work_3 = FactoryBot.create(:work, investigation_id: investigation.id)

    get api_v1_works_path
    works_response = JSON.parse(response.body, symbolize_names: true)[:data]
    
    expect(response).to be_successful
    works_response.each do |work|
      expect(work).to have_key(:id)
      expect(work).to have_key(:doi)
      expect(work).to have_key(:title)
    end
  end

  it 'can create a new work' do
    user = FactoryBot.create(:user)
    investigation = FactoryBot.create(:investigation, user_id: user.id)

    headers = {"CONTENT_TYPE" => "application/json"}

    work_params = {
      investigation_id: "#{investigation.id}",
      title: "A Super Cool Work",
      doi: "10.1111/2222222"
    }

    post api_v1_works_path, headers: headers, params: JSON.generate(work: work_params)

    expect(response).to be_successful
    response_data = JSON.parse(response.body, symbolize_names: true)[:data].first

    new_work = Work.last
    
    expect(response_data[:id]).to eq(new_work.id)
    expect(response_data[:title]).to eq(new_work.title)
    expect(response_data[:doi]).to eq(new_work.doi)
  end

  it 'can delete a work' do
    user = FactoryBot.create(:user)
    investigation = FactoryBot.create(:investigation, user_id: user.id)
    work = FactoryBot.create(:work, investigation_id: investigation.id)

    headers = {"CONTENT_TYPE" => "application/json"}

    delete api_v1_work_path(work.id), headers: headers

    expect(response).to be_successful
    expect(response.status).to eq(204)
  end

  it 'can update a work' do
    user = FactoryBot.create(:user)
    investigation = FactoryBot.create(:investigation, user_id: user.id)
    work = FactoryBot.create(:work, title: "The Original Title", investigation_id: investigation.id)

    headers = {"CONTENT_TYPE" => "application/json"}

    work_params = {
      title: "A Cool New Title"
    }

    patch api_v1_work_path(work.id), headers: headers, params: JSON.generate(work_params)

    work_response = JSON.parse(response.body, symbolize_names: true)[:data].first

    expect(response).to be_successful
    expect(work_response).to have_key(:id)
    expect(work_response[:id]).to eq(work.id)
    expect(work_response).to have_key(:doi)
    expect(work_response[:doi]).to eq(work.doi)
    expect(work_response).to have_key(:title)
    expect(work_response[:title]).to eq("A Cool New Title")
  end

end