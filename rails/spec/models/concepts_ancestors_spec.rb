# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ConceptsAncestors, type: :model do
  describe 'relationships' do
    it { should belong_to :concept }
    it { should belong_to :ancestor }
  end
end
