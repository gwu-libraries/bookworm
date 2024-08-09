# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Edge, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:investigation_id) }
    it { should validate_presence_of(:connection_id) }
    it { should validate_presence_of(:visible) }
  end

  describe 'relationships' do
    it { should belong_to :investigation }
    it { should belong_to :connection }
  end
end
