# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'investigations API' do
  it 'can return one investigation by ID' do
    user = FactoryBot.create(:user)
    investigation_1 = FactoryBot.create(:investigation, user_id: user.id)

    get api_v1_investigation_path(investigation_1.id)

    expect(response).to be_successful

    investigation_response = JSON.parse(response.body, symbolize_names: true)[:data].first

    expect(investigation_response).to have_key(:id)
    expect(investigation_response[:id]).to eq(investigation_1.id)
    expect(investigation_response).to have_key(:name)
    expect(investigation_response[:name]).to eq(investigation_1.name)
  end

  it 'can return a list of all investigations' do
    user = FactoryBot.create(:user)
    FactoryBot.create(:investigation, user_id: user.id)
    FactoryBot.create(:investigation, user_id: user.id)
    FactoryBot.create(:investigation, user_id: user.id)

    get api_v1_investigations_path
    investigations_response = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to be_successful
    investigations_response.each do |investigation|
      expect(investigation).to have_key(:id)
      expect(investigation).to have_key(:user_id)
      expect(investigation).to have_key(:name)
    end
  end

  it 'can create a new investigation' do
    user = FactoryBot.create(:user)
    headers = { 'CONTENT_TYPE' => 'application/json' }

    investigation_params = {
      user_id: user.id.to_s,
      name: 'Beefaroni Investigation'
    }

    post api_v1_investigations_path, headers:, params: JSON.generate(investigation: investigation_params)

    expect(response).to be_successful
    response_data = JSON.parse(response.body, symbolize_names: true)[:data].first

    new_investigation = Investigation.last

    expect(response_data[:id]).to eq(new_investigation.id)
    expect(response_data[:name]).to eq(new_investigation.name)
    expect(Investigation.count).to eq(1)
  end

  it 'does not create a new investigation if no name given' do
    user = FactoryBot.create(:user)
    headers = { 'CONTENT_TYPE' => 'application/json' }

    investigation_params = {
      user_id: user.id
    }

    post api_v1_investigations_path, headers:, params: JSON.generate(investigation: investigation_params)

    expect(response).to_not be_successful
    expect(Investigation.count).to eq(0)
  end
end
