require 'rails_helper'

RSpec.describe 'works API' do

  before :each do
    @user = FactoryBot.create(:user)
    @investigation = FactoryBot.create(:investigation, user_id: @user.id)

    @work_1 = FactoryBot.create(:work, investigation_id: @investigation.id)
    @work_2 = FactoryBot.create(:work, investigation_id: @investigation.id)
    @work_3 = FactoryBot.create(:work, investigation_id: @investigation.id)
  end

  it 'can return one work by ID' do
    get api_v1_work_path(@work_1.id)

    expect(response).to be_successful

    work_response = JSON.parse(response.body, symbolize_names: true)[:data].first

    expect(work_response).to have_key(:id)
    expect(work_response[:id]).to eq(@work_1.id)
    expect(work_response).to have_key(:investigation_id)
    expect(work_response[:investigation_id]).to eq(@investigation.id)
    expect(work_response).to have_key(:doi)
    expect(work_response[:doi]).to eq(@work_1.doi)
    expect(work_response).to have_key(:title)
    expect(work_response[:title]).to eq(@work_1.title)
  end

  it 'can return a list of all works' do
    get api_v1_works_path

    works_response = JSON.parse(response.body, symbolize_names: true)[:data]
    
    expect(response).to be_successful
    works_response.each do |work|
      expect(work).to have_key(:id)
      expect(work).to have_key(:investigation_id)
      expect(work).to have_key(:doi)
      expect(work).to have_key(:title)
    end
  end

  it 'can create a new work' do
    headers = {"CONTENT_TYPE" => "application/json"}

    work_params = {
      investigation_id: "#{@investigation.id}",
      title: "A Super Cool Work",
      doi: "10.1111/2222222"
    }

    post api_v1_works_path, headers: headers, params: JSON.generate(work: work_params)

    expect(response).to be_successful
    response_data = JSON.parse(response.body, symbolize_names: true)[:data].first

    new_work = Work.last
    
    expect(response_data[:id]).to eq(new_work.id)
    expect(response_data[:investigation_id]).to eq(@investigation.id)
    expect(response_data[:title]).to eq(new_work.title)
    expect(response_data[:doi]).to eq(new_work.doi)
  end

  it 'does not create a new work if investigation_id is blank' do
    headers = {"CONTENT_TYPE" => "application/json"}

    work_params = {
      title: "A Super Cool Work",
      doi: "10.1111/2222222"
    }

    post api_v1_works_path, headers: headers, params: JSON.generate(work: work_params)

    expect(response).to_not be_successful
  end

  it 'does not create a new work if title is blank' do
    headers = {"CONTENT_TYPE" => "application/json"}

    work_params = {
      investigation_id: "#{@investigation.id}",
      doi: "10.1111/2222222"
    }

    post api_v1_works_path, headers: headers, params: JSON.generate(work: work_params)

    expect(response).to_not be_successful
  end

  it 'does not create a new work if doi is blank' do
    headers = {"CONTENT_TYPE" => "application/json"}

    work_params = {
      investigation_id: "#{@investigation.id}",
      title: "A Super Cool New Work"
    }

    post api_v1_works_path, headers: headers, params: JSON.generate(work: work_params)

    expect(response).to_not be_successful
  end

  it 'can delete a work' do
    headers = {"CONTENT_TYPE" => "application/json"}

    delete api_v1_work_path(@work_1.id), headers: headers

    expect(response).to be_successful
    expect(response.status).to eq(204)
    expect(Work.count).to eq(2)
  end

  it 'can update a work' do
    headers = {"CONTENT_TYPE" => "application/json"}

    work_params = {
      title: "A Cool New Title"
    }

    patch api_v1_work_path(@work_1.id), headers: headers, params: JSON.generate(work_params)

    work_response = JSON.parse(response.body, symbolize_names: true)[:data].first

    expect(response).to be_successful
    expect(work_response).to have_key(:id)
    expect(work_response[:id]).to eq(@work_1.id)
    expect(work_response).to have_key(:investigation_id)
    expect(work_response[:investigation_id]).to eq(@investigation.id)
    expect(work_response).to have_key(:doi)
    expect(work_response[:doi]).to eq(@work_1.doi)
    expect(work_response).to have_key(:title)
    expect(work_response[:title]).to eq("A Cool New Title")
  end

  it 'can add a citation to a work' do
    expect(@work_1.citations.count).to eq(0)

    @work_1.add_citation(@work_2.id)

    expect(@work_1.citations.count).to eq(1)
  end

  it 'is added as a "reference" for a citing article' do
    expect(@work_2.references.count).to eq(0)

    @work_1.add_citation(@work_2.id)

    expect(@work_2.references.count).to eq(1)
  end

  it 'can add a reference to a work' do
    expect(@work_1.references.count).to eq(0)

    @work_1.add_reference(@work_2.id)

    expect(@work_1.references.count).to eq(1)
  end

  it 'is added as a "citation" for a reference article' do
    expect(@work_2.citations.count).to eq(0)

    @work_1.add_reference(@work_2.id)

    expect(@work_2.citations.count).to eq(1)
  end

end