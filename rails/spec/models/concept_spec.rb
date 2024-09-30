# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Concept, type: :model do

  describe 'relationships' do
    it { should have_many :works_concepts }
    it { should have_many(:works).through(:works_concepts) }
    it { should have_one :concepts_counts_by_year }
    it { should have_one :concepts_ids }

    it { should have_many(:concepts_related_concepts) }
    it { should have_many(:related_concepts).through(:concepts_related_concepts) }
  end
end
