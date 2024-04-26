require 'rails_helper'

RSpec.describe InvestigationWork, type: :model do

  describe 'validations' do
    it { should validate_presence_of :investigation_id }
    it { should validate_presence_of :work_id }
  end

  describe 'relationships' do
    it { should belong_to :investigation }
    it { should belong_to :work }
  end

end