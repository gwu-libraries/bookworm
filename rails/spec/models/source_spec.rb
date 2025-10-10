# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Source, type: :model do
  describe 'relationships' do
    it { should have_many(:works_primary_locations) }
    it { should have_many(:works).through(:works_primary_locations) }
  end
end
