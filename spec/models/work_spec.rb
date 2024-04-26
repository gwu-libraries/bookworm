require 'rails_helper'

RSpec.describe Work, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:doi) }
  end

  describe 'relationships' do
    it { should have_many :investigation_works }
    it { should have_many(:investigations).through(:investigation_works) }

    it { should have_many :reference_connections }
    it { should have_many(:references).through(:reference_connections) }

    it { should have_many :citation_connections }
    it { should have_many(:citations).through(:citation_connections) }
  end

  describe 'methods' do
    it 'returns a hash in tree format of citations and references' do
      user = FactoryBot.create(:user, email: "admin@example.com", password: "pjassword")

      main_investigation = FactoryBot.create(:investigation)
        FactoryBot.create(:user_investigation, user_id: user.id, investigation_id: main_investigation.id)

      main_root_work = FactoryBot.create(:work)
        FactoryBot.create(:investigation_work, investigation_id: main_investigation.id, work_id: main_root_work.id)
      
      references = []
      5.times do
        reference = FactoryBot.create(:work)
        FactoryBot.create(:investigation_work, investigation_id: main_investigation.id, work_id: main_root_work.id)
        references << reference
      end

      references.each do |reference|
        FactoryBot.create(:connection, reference_id: reference.id, citation_id: main_root_work.id)
      end

      citations = []
      5.times do
        citation = FactoryBot.create(:work)
        FactoryBot.create(:investigation_work, investigation_id: main_investigation.id, work_id: main_root_work.id)
        citations << citation
      end

      citations.each do |citation|
        FactoryBot.create(:connection, reference_id: main_root_work.id, citation_id: citation.id)
      end

      expected = {
        "name": main_root_work.title,
        "children": [
          {
          "name": "citations",
          "children": [
            {"name": citations[0].title},
            {"name": citations[1].title},
            {"name": citations[2].title},
            {"name": citations[3].title},
            {"name": citations[4].title}
          ]
          },
          {
            "name": "references",
            "children": [
              {"name": references[0].title},
              {"name": references[1].title},
              {"name": references[2].title},
              {"name": references[3].title},
              {"name": references[4].title},
            ]
          }
        ]
      }

      actual = main_root_work.citation_reference_tree_json

      expect(actual).to eq(expected)
    end
  end

end