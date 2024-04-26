require 'rails_helper'

RSpec.describe Investigation, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'relationships' do
    it { should have_many :investigation_works }
    it { should have_many(:works).through(:investigation_works) }
  end

end