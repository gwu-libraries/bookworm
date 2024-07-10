# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CrossrefService do
  context '#get_paper_details' do
    it 'returns details about a paper', :vcr do
      doi = '10.1086/227049'

      response = CrossrefService.get_paper_details(doi)

      expect(response).to be_a(Hash)
      expect(response).to have_key(:message)
      expect(response[:message]).to be_a(Hash)
      expect(response[:message]).to have_key(:indexed)
      expect(response[:message][:indexed]).to be_a(Hash)
      expect(response[:message][:indexed]).to have_key(:'date-parts')
      expect(response[:message][:indexed][:'date-parts']).to be_a(Array)
      expect(response[:message][:indexed]).to have_key(:'date-time')
      expect(response[:message][:indexed][:'date-time']).to be_a(String)
      expect(response[:message][:indexed]).to have_key(:timestamp)
      expect(response[:message][:indexed][:timestamp]).to be_a(Integer)
      expect(response[:message]).to have_key(:'reference-count')
      expect(response[:message][:'reference-count']).to be_a(Integer)
      expect(response[:message]).to have_key(:publisher)
      expect(response[:message][:publisher]).to be_a(String)
      expect(response[:message]).to have_key(:issue)
      expect(response[:message][:issue]).to be_a(String)
      expect(response[:message]).to have_key(:'content-domain')
      expect(response[:message][:'content-domain']).to be_a(Hash)
      expect(response[:message][:'content-domain']).to have_key(:domain)
      expect(response[:message][:'content-domain'][:domain]).to be_a(Array)
      expect(response[:message][:'content-domain']).to have_key(
        :'crossmark-restriction'
      )
      expect(response[:message]).to have_key(:'short-container-title')
      expect(response[:message][:'short-container-title']).to be_a(Array)
      expect(response[:message]).to have_key(:'published-print')
      expect(response[:message][:'published-print']).to be_a(Hash)
      expect(response[:message][:'published-print']).to have_key(:'date-parts')
      expect(response[:message][:'published-print'][:'date-parts']).to be_a(
        Array
      )
      expect(response[:message]).to have_key(:DOI)
      expect(response[:message][:DOI]).to be_a(String)
      expect(response[:message]).to have_key(:type)
      expect(response[:message][:type]).to be_a(String)
      expect(response[:message]).to have_key(:created)
      expect(response[:message][:created]).to be_a(Hash)
      expect(response[:message][:created]).to have_key(:'date-parts')
      expect(response[:message][:created][:'date-parts']).to be_a(Array)
      expect(response[:message][:created]).to have_key(:'date-time')
      expect(response[:message][:created][:'date-time']).to be_a(String)
      expect(response[:message][:created]).to have_key(:timestamp)
      expect(response[:message][:created][:timestamp]).to be_a(Integer)
      expect(response[:message]).to have_key(:page)
      expect(response[:message][:page]).to be_a(String)
      expect(response[:message]).to have_key(:source)
      expect(response[:message][:source]).to be_a(String)
      expect(response[:message]).to have_key(:'is-referenced-by-count')
      expect(response[:message][:'is-referenced-by-count']).to be_a(Integer)
      expect(response[:message]).to have_key(:title)
      expect(response[:message][:title]).to be_a(Array)
      expect(response[:message]).to have_key(:prefix)
      expect(response[:message][:prefix]).to be_a(String)
      expect(response[:message]).to have_key(:volume)
      expect(response[:message][:volume]).to be_a(String)
      expect(response[:message]).to have_key(:author)
      expect(response[:message][:author]).to be_a(Array)
      expect(response[:message][:author].first).to be_a(Hash)
      expect(response[:message][:author].first).to have_key(:given)
      expect(response[:message][:author].first[:given]).to be_a(String)
      expect(response[:message][:author].first).to have_key(:family)
      expect(response[:message][:author].first[:family]).to be_a(String)
      expect(response[:message][:author].first).to have_key(:sequence)
      expect(response[:message][:author].first[:sequence]).to be_a(String)
      expect(response[:message][:author].first).to have_key(:affiliation)
      expect(response[:message][:author].first[:affiliation]).to be_a(Array)
      expect(response[:message]).to have_key(:member)
      expect(response[:message][:member]).to be_a(String)
      expect(response[:message]).to have_key(:'container-title')
      expect(response[:message][:'container-title']).to be_a(Array)
      expect(response[:message][:'container-title'].first).to be_a(String)
      expect(response[:message]).to have_key(:'original-title')
      expect(response[:message][:'original-title']).to be_a(Array)
      expect(response[:message]).to have_key(:language)
      expect(response[:message][:language]).to be_a(String)
      expect(response[:message]).to have_key(:link)
      expect(response[:message][:link]).to be_a(Array)
      expect(response[:message][:link].first).to be_a(Hash)
      expect(response[:message][:link].first).to have_key(:URL)
      expect(response[:message][:link].first[:URL]).to be_a(String)
      expect(response[:message][:link].first).to have_key(:'content-type')
      expect(response[:message][:link].first[:'content-type']).to be_a(String)
      expect(response[:message][:link].first).to have_key(:'content-version')
      expect(response[:message][:link].first[:'content-version']).to be_a(
        String
      )
      expect(response[:message][:link].first).to have_key(
        :'intended-application'
      )
      expect(response[:message][:link].first[:'intended-application']).to be_a(
        String
      )
      expect(response[:message]).to have_key(:deposited)
      expect(response[:message][:deposited]).to be_a(Hash)
      expect(response[:message][:deposited]).to have_key(:'date-parts')
      expect(response[:message][:deposited][:'date-parts']).to be_a(Array)
      expect(response[:message][:deposited]).to have_key(:'date-time')
      expect(response[:message][:deposited][:'date-time']).to be_a(String)
      expect(response[:message][:deposited]).to have_key(:timestamp)
      expect(response[:message][:deposited][:timestamp]).to be_a(Integer)
      expect(response[:message]).to have_key(:score)
      expect(response[:message][:score]).to be_a(Integer)
      expect(response[:message]).to have_key(:resource)
      expect(response[:message][:resource]).to be_a(Hash)
      expect(response[:message][:resource]).to have_key(:primary)
      expect(response[:message][:resource][:primary]).to be_a(Hash)
      expect(response[:message][:resource][:primary]).to have_key(:URL)
      expect(response[:message][:resource][:primary][:URL]).to be_a(String)
      expect(response[:message]).to have_key(:subtitle)
      expect(response[:message][:subtitle]).to be_a(Array)
      expect(response[:message]).to have_key(:'short-title')
      expect(response[:message][:'short-title']).to be_a(Array)
      expect(response[:message]).to have_key(:issued)
      expect(response[:message][:issued]).to be_a(Hash)
      expect(response[:message][:issued]).to have_key(:'date-parts')
      expect(response[:message][:issued][:'date-parts']).to be_a(Array)
      expect(response[:message]).to have_key(:'references-count')
      expect(response[:message][:'references-count']).to be_a(Integer)
      expect(response[:message]).to have_key(:'journal-issue')
      expect(response[:message][:'journal-issue']).to be_a(Hash)
      expect(response[:message][:'journal-issue']).to have_key(:issue)
      expect(response[:message][:'journal-issue'][:issue]).to be_a(String)
      expect(response[:message][:'journal-issue']).to have_key(
        :'published-print'
      )
      expect(response[:message][:'journal-issue'][:'published-print']).to be_a(
        Hash
      )
      expect(
        response[:message][:'journal-issue'][:'published-print']
      ).to have_key(:'date-parts')
      expect(
        response[:message][:'journal-issue'][:'published-print'][:'date-parts']
      ).to be_a(Array)
      expect(response[:message]).to have_key(:'alternative-id')
      expect(response[:message][:'alternative-id']).to be_a(Array)
      expect(response[:message][:'alternative-id'].first).to be_a(String)
      expect(response[:message]).to have_key(:URL)
      expect(response[:message][:URL]).to be_a(String)
      expect(response[:message]).to have_key(:relation)
      expect(response[:message][:relation]).to be_a(Hash)
      expect(response[:message]).to have_key(:ISSN)
      expect(response[:message][:ISSN]).to be_a(Array)
      expect(response[:message][:ISSN].first).to be_a(String)
      expect(response[:message]).to have_key(:'issn-type')
      expect(response[:message][:'issn-type']).to be_a(Array)
      expect(response[:message][:'issn-type'].first).to be_a(Hash)
      expect(response[:message][:'issn-type'].first).to have_key(:value)
      expect(response[:message][:'issn-type'].first[:value]).to be_a(String)
      expect(response[:message][:'issn-type'].first).to have_key(:type)
      expect(response[:message][:'issn-type'].first[:type]).to be_a(String)
      expect(response[:message]).to have_key(:subject)
      expect(response[:message][:subject]).to be_a(Array)
      expect(response[:message]).to have_key(:published)
      expect(response[:message][:published]).to be_a(Hash)
      expect(response[:message][:published]).to have_key(:'date-parts')
      expect(response[:message][:published][:'date-parts']).to be_a(Array)
    end
  end

  context 'get_paper_references' do
    it 'returns references for a paper by doi', :vcr do
      doi = '10.1016/J.COMPOSITESB.2018.01.027'

      response = CrossrefService.get_paper_references(doi)

      expect(response).to be_a(Array)
    end
  end
end
