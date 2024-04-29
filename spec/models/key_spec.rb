# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Key, type: :model do
  describe 'validations' do
    it { should validate_presence_of :site }
    it { should validate_presence_of :value }
    it { should validate_presence_of :user_id }
  end

  describe 'relationships' do
    it { should belong_to :user }
  end
end
