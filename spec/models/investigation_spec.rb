# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Investigation, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it { should have_many :works }
    it { should belong_to :user }
  end
end
