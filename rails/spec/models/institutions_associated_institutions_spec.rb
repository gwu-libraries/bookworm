# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InstitutionsAssociatedInstitutions, type: :model do
  describe 'relationships' do
    it { should belong_to :associating_institution }
    it { should belong_to :associated_institution }
  end
end
