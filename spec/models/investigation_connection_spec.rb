# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InvestigationConnection, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:investigation_id) }
    it { should validate_presence_of(:connection_id) }
  end

  describe 'relationships' do
    it { should belong_to :investigation }
    it { should belong_to :connection }
  end
end
