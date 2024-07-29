# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Investigation, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it { should have_many :work_nodes }
    it { should have_many(:works).through(:work_nodes) }

    it { should have_many(:author_nodes) }
    it { should have_many(:authors).through(:author_nodes) }

    it { should have_many(:note_nodes) }

    it { should belong_to :user }
  end
end
