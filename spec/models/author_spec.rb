# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Author, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should allow_value(nil).for (:orcid) }
    it { should allow_value(nil).for (:openalex_id) }
  end
  describe 'relationships' do
    it { should have_many :author_nodes }
    it { should have_many(:investigations).through(:author_nodes) }

    it { should have_many :author_works }
    it { should have_many(:works).through(:author_works) }
  end
end
