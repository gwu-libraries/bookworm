# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WorksIds, type: :model do
  describe 'relationships' do
    it { should belong_to :work }
  end
end
