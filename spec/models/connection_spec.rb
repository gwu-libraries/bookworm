# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Connection, type: :model do
  describe 'validations' do
    it { should validate_presence_of :reference_id }
    it { should validate_presence_of :citation_id }
  end

  describe 'relationships' do
    it { should belong_to :reference }
    it { should belong_to :citation }

    it { should have_many(:investigation_connections) }
    it { should have_many(:investigations).through(:investigation_connections) }
  end
end
