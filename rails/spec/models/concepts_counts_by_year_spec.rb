# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ConceptsCountsByYear, type: :model do
  describe 'relationships' do
    it { should belong_to :concept }
  end
end
