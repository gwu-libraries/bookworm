# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Work, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:doi) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:investigation_id) }
  end

  describe 'relationships' do
    it { should belong_to :investigation }

    it { should have_many :reference_connections }
    it { should have_many(:references).through(:reference_connections) }

    it { should have_many :citation_connections }
    it { should have_many(:citations).through(:citation_connections) }
  end
end
