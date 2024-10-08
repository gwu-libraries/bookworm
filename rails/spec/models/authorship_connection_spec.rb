# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthorshipConnection, type: :model do
  describe 'relationships' do
    it { should belong_to :author }
    it { should belong_to :work }
  end
end
