# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Institution, type: :model do
  describe 'relationships' do
    it { should have_many :institutions_counts_by_year }
    it { should have_one :institutions_ids }
    it { should have_one :institutions_geo }

    it { should have_many(:works_authorships) }
    it { should have_many(:authors).through(:works_authorships) }
    it { should have_many(:works).through(:works_authorships) }
  end
end
