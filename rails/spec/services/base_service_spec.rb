# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BaseService do
  describe 'openalex_connection' do
    it 'returns a response' do
      service = BaseService.openalex_connection

      expect(service).to be_a(Object)
    end
  end
end
