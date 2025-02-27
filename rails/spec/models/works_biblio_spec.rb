# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WorksBiblio, type: :model do
  describe 'relationships' do
    it { should belong_to :work }
  end
end
