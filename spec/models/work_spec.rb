# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Work, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:doi) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:investigation_id) }
  end

  describe 'relationships' do
    it { should belong_to :investigation }

    it { should have_many :reference_connections }
    it { should have_many(:references).through(:reference_connections) }

    it { should have_many :citation_connections }
    it { should have_many(:citations).through(:citation_connections) }
  end

  describe 'methods' do
    it 'returns a hash in tree format of citations and references' do
      user = FactoryBot.create(:user, email: 'admin@example.com', password: 'pjassword')

      main_investigation = FactoryBot.create(:investigation, user_id: user.id)

      main_investigation_main_work = FactoryBot.create(:work, investigation_id: main_investigation.id, root_work: true)

      references = []
      5.times do
        reference = FactoryBot.create(:work, investigation_id: main_investigation.id)
        references << reference
      end

      references.each do |reference|
        FactoryBot.create(:connection, reference_id: reference.id, citation_id: main_investigation_main_work.id)
      end

      citations = []
      5.times do
        citation = FactoryBot.create(:work, investigation_id: main_investigation.id)
        citations << citation
      end

      citations.each do |citation|
        FactoryBot.create(:connection, reference_id: main_investigation_main_work.id, citation_id: citation.id)
      end

      expected =
        {
          "id": main_investigation_main_work.id,
          "data":
            {
              "name": main_investigation_main_work.title,
              "children": [
                {
                  "name": 'citations',
                  "children": [
                    {
                      "title": citations[0].title,
                      "id": citations[0].id,
                      "doi": citations[0].doi
                    },
                    {
                      "title": citations[1].title,
                      "id": citations[1].id,
                      "doi": citations[1].doi
                    },
                    {
                      "title": citations[2].title,
                      "id": citations[2].id,
                      "doi": citations[2].doi
                    },
                    {
                      "title": citations[3].title,
                      "id": citations[3].id,
                      "doi": citations[3].doi
                    },
                    {
                      "title": citations[4].title,
                      "id": citations[4].id,
                      "doi": citations[4].doi
                    }
                  ]
                },
                {
                  "name": 'references',
                  "children": [
                    {
                      "title": references[0].title,
                      "id": references[0].id,
                      "doi": references[0].doi
                    },
                    {
                      "title": references[1].title,
                      "id": references[1].id,
                      "doi": references[1].doi
                    },
                    {
                      "title": references[2].title,
                      "id": references[2].id,
                      "doi": references[2].doi
                    },
                    {
                      "title": references[3].title,
                      "id": references[3].id,
                      "doi": references[3].doi
                    },
                    {
                      "title": references[4].title,
                      "id": references[4].id,
                      "doi": references[4].doi
                    }
                  ]
                }
              ]
            }
        }

      actual = main_investigation_main_work.citation_reference_tree

      expect(actual).to eq(expected)
    end
  end
end
