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

end