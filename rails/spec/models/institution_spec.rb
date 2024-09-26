# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Institution, type: :model do
  describe 'relationships' do
    it { should have_one :institutions_counts_by_year }
    it { should have_one :institutions_ids }
  end
end