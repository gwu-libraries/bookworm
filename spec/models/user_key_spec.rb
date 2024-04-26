require 'rails_helper'

RSpec.describe UserKey, type: :model do

  describe 'validations' do
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :key_id }
  end

  describe 'relationships' do
    it { should belong_to :user }
    it { should belong_to :key }
  end
end