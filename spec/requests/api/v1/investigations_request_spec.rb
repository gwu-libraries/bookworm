require 'rails_helper'

RSpec.describe 'investigations API' do

  it 'can return one investigation by ID' do
    investigation_1 = FactoryBot.create(:investigation)

    get api_v1_investigation_path(investigation_1.id)

    expect(response).to be_successful

    investigation_response = JSON.parse(response.body, symbolize_names: true)

    expect(investigation_response).to have_key(:id)
    expect(investigation_response[:id]).to eq(investigation_1.id)
    expect(investigation_response).to have_key(:name)
    expect(investigation_response[:name]).to eq(investigation_1.name)
  end

  it 'can create a new investigation' do
    headers = {"CONTENT_TYPE" => "application/json"}

    investigation_params = {
      name: "Beefaroni Investigation"
    }

    post api_v1_investigations_path, headers: headers, params: JSON.generate(investigation: investigation_params)

    expect(response).to be_successful
    response_data = JSON.parse(response.body, symbolize_names: true)[:data]
    
    new_investigation = Investigation.last

    expect(response_data[:id]).to eq(new_investigation.id)
    expect(response_data[:name]).to eq(new_investigation.name)
    expect(Investigation.count).to eq(1)
  end

  it 'does not create a new investigation if no name given' do
    headers = {"CONTENT_TYPE" => "application/json"}

    investigation_params = {}

    post api_v1_investigations_path, headers: headers, params: JSON.generate(investigation: investigation_params)

    expect(response).to_not be_successful
    expect(Investigation.count).to eq(0)
  end

end