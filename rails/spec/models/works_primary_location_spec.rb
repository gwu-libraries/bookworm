# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WorksPrimaryLocation, type: :model do
  describe 'relationships' do
    it { should belong_to :work }
    it { should belong_to :source }
  end
end
