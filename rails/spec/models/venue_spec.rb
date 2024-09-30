# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Venue, type: :model do
  describe 'relationships' do
    # it { should have_many :works_alternate_host_venues }
    # it { should have_many(:works).through(:works_alternate_host_venues) }
    it { should have_one :venues_counts_by_year }
    it { should have_one :venues_ids }
  end
end
