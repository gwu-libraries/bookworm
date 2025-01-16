# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthorsCountsByYear, type: :model do
  describe 'relationships' do
    it { should belong_to :author }
  end
end
