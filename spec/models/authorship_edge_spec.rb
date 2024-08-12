# frozen_string_literal

require 'rails_helper'

RSpec.describe AuthorshipEdge, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:investigation_id) }
    it { should validate_presence_of(:authorship_connection_id) }
    it { should validate_presence_of(:visible) }
  end

  describe 'relationships' do
    it { should belong_to :investigation }
    it { should belong_to :authorship_connection }
  end
end
