# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ConceptsRelatedConcepts, type: :model do
  describe 'relationships' do
    it { should belong_to :concept }
    it { should belong_to :related_concept }
  end
end
