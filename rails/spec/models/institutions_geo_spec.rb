# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InstitutionsGeo, type: :model do
  describe 'relationships' do
    it { should belong_to :institution }
  end
end
