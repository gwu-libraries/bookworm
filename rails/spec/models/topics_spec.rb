# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Topic, type: :model do
  describe 'relationships' do
    it { should have_many :works_topics }
    it { should have_many(:works).through(:works_topics) }
  end
end
