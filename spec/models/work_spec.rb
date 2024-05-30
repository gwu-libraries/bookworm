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
          "work_id": main_investigation_main_work.id,
          "attributes": {
            "title": main_investigation_main_work.title,
            "doi": main_investigation_main_work.doi
          },
          "citations": [
            {
              "work_id": citations[0].id,
              "attributes": {
                "title": citations[0].title,
                "doi": citations[0].doi
              }
            },
            {
              "work_id": citations[1].id,
              "attributes": {
                "title": citations[1].title,
                "doi": citations[1].doi
              }
            },
            {
              "work_id": citations[2].id,
              "attributes": {
                "title": citations[2].title,
                "doi": citations[2].doi
              }
            },
            {
              "work_id": citations[3].id,
              "attributes": {
                "title": citations[3].title,
                "doi": citations[3].doi
              }
            },
            {
              "work_id": citations[4].id,
              "attributes": {
                "title": citations[4].title,
                "doi": citations[4].doi
              }
            }
          ],
          "references": [
            {
              "work_id": references[0].id,
              "attributes": {
                "title": references[0].title,
                "doi": references[0].doi
              }
            },
            {
              "work_id": references[1].id,
              "attributes": {
                "title": references[1].title,
                "doi": references[1].doi
              }
            },
            {
              "work_id": references[2].id,
              "attributes": {
                "title": references[2].title,
                "doi": references[2].doi
              }
            },
            {
              "work_id": references[3].id,
              "attributes": {
                "title": references[3].title,
                "doi": references[3].doi
              }
            },
            {
              "work_id": references[4].id,
              "attributes": {
                "title": references[4].title,
                "doi": references[4].doi
              }
            }
          ]
        }

      actual = main_investigation_main_work.citation_reference_tree

      expect(actual).to eq(expected)
    end
  end
end
