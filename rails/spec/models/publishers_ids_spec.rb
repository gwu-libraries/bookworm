# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PublishersIds, type: :model do
  describe 'relationships' do
    it { should belong_to :publisher }
  end
end
