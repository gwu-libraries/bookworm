# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'keys API' do
  it 'can return one key by ID' do
    user = FactoryBot.create(:user)
    key = FactoryBot.create(:key, user_id: user.id)

    get api_v1_key_path(key.id)

    expect(response).to be_successful

    key_response = JSON.parse(response.body, symbolize_names: true)[:data].first

    expect(key_response).to have_key(:id)
    expect(key_response[:id]).to eq(key.id)
    expect(key_response).to have_key(:value)
    expect(key_response[:value]).to eq(key.value)
    expect(key_response).to have_key(:site)
    expect(key_response[:site]).to eq(key.site)
  end

  it 'can return a list of all keys' do
    user = FactoryBot.create(:user)
    FactoryBot.create(:key, user_id: user.id)
    FactoryBot.create(:key, user_id: user.id)
    FactoryBot.create(:key, user_id: user.id)

    get api_v1_keys_path
    keys_response = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to be_successful
    keys_response.each do |key|
      expect(key).to have_key(:id)
      expect(key).to have_key(:user_id)
      expect(key).to have_key(:value)
      expect(key).to have_key(:site)
    end
  end

  it 'can create a new key' do
    user = FactoryBot.create(:user)

    headers = { 'CONTENT_TYPE' => 'application/json' }

    key_params = {
      user_id: user.id.to_s,
      site: 'semanticscholar',
      value: '123iamakey'
    }

    post api_v1_keys_path, headers:, params: JSON.generate(key: key_params)

    expect(response).to be_successful
    response_data = JSON.parse(response.body, symbolize_names: true)[:data].first

    new_key = Key.last
    expect(response_data[:id]).to eq(new_key.id)
    expect(response_data[:user_id]).to eq(new_key.user_id)
    expect(response_data[:site]).to eq(new_key.site)
    expect(response_data[:value]).to eq(new_key.value)
  end

  it 'does not create a new key if user_id is blank' do
    FactoryBot.create(:user)
    headers = { 'CONTENT_TYPE' => 'application/json' }
    key_params = {
      site: 'acoolwebsite',
      value: '123coolkey'
    }

    post api_v1_keys_path, headers:, params: JSON.generate(key: key_params)

    expect(response).to_not be_successful
  end

  it 'does not create a new key if site is blank' do
    user = FactoryBot.create(:user)
    headers = { 'CONTENT_TYPE' => 'application/json' }
    key_params = {
      user_id: user.id.to_s,
      value: '123coolkey'
    }

    post api_v1_keys_path, headers:, params: JSON.generate(key: key_params)

    expect(response).to_not be_successful
  end
  it 'does not create a new key if value is blank' do
    user = FactoryBot.create(:user)
    headers = { 'CONTENT_TYPE' => 'application/json' }
    key_params = {
      user_id: user.id.to_s,
      site: 'acoolwebsite'
    }

    post api_v1_keys_path, headers:, params: JSON.generate(key: key_params)

    expect(response).to_not be_successful
  end

  it 'can delete a key' do
    user = FactoryBot.create(:user)
    key = FactoryBot.create(:key, user_id: user.id)
    headers = { 'CONTENT_TYPE' => 'application/json' }

    delete(api_v1_key_path(key.id), headers:)

    expect(response).to be_successful
    expect(response.status).to eq(204)
    expect(Key.count).to eq(0)
  end
end
