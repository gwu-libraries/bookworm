# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Author, type: :model do
  describe 'validations' do
    it { should allow_value(nil).for (:display_name) }
    it { should allow_value(nil).for (:orcid) }
    it { should allow_value(nil).for (:display_name) }
    it { should allow_value(nil).for (:display_name_alternatives) }
    it { should allow_value(nil).for (:works_count) }
    it { should allow_value(nil).for (:cited_by_count) }
    it { should allow_value(nil).for (:last_known_institution) }
  end
  describe 'relationships' do
    # it { should have_many :author_nodes }
    it { should have_one :authors_ids }
    it { should have_one :authors_counts_by_year }

    # it { should have_many :authorship_connections }
    # it { should have_many(:works).through(:authorship_connections) }
  end
end
