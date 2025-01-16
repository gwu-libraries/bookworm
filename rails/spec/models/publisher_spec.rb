# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Publisher, type: :model do
  describe 'relationships' do
    it { should have_one :publishers_ids }
    it { should have_many :publishers_counts_by_year }
  end
end
