# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WorkNode, type: :model do
  describe 'validations' do
    it { should allow_value(nil).for(:x_coordinate) }
    it { should allow_value(nil).for(:y_coordinate) }

    it { should validate_presence_of(:visible) }
  end

  describe 'relationships' do
    it { should belong_to :investigation }
    it { should belong_to :work }
  end
end
