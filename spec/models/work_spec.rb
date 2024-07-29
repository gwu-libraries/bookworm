# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Work, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:doi) }
    it { should validate_presence_of(:title) }
  end

  describe 'relationships' do
    it { should have_many :work_nodes }
    it { should have_many(:investigations).through(:work_nodes) }

    it { should have_many :author_works }
    it { should have_many(:authors).through(:author_works) }

    it { should have_many :reference_connections }
    it { should have_many(:references).through(:reference_connections) }

    it { should have_many :citation_connections }
    it { should have_many(:citations).through(:citation_connections) }
  end
end
