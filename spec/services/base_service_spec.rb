# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BaseService do
  describe '#semantic_scholar_connection' do
    it 'returns a response' do
      service = BaseService.semantic_scholar_connection

      expect(service).to be_a(Object)
    end
  end

  describe '#crossref_connection' do
    it 'returns a response' do
      service = BaseService.crossref_connection

      expect(service).to be_a(Object)
    end
  end
end
