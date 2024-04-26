require 'rails_helper'

RSpec.describe UserInvestigation, type: :model do

  describe 'validations' do
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :investigation_id }
  end

  describe 'relationships' do
    it { should belong_to :user }
    it { should belong_to :investigation }
  end

end