# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VenuesIds, type: :model do
  describe 'relationships' do
    it { should belong_to :venue }
  end
end