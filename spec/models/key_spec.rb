require 'rails_helper'

RSpec.describe Key, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:site) }
    it { should validate_presence_of(:value) }
  end

  describe 'relationships' do
    it { should have_many :user_keys }
    it { should have_many(:users).through(:user_keys) }
  end

end