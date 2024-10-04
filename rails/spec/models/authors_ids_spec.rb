# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthorsIds, type: :model do
  describe 'validations' do
    it { should allow_value(nil).for (:openalex) }
    it { should allow_value(nil).for (:orcid) }
    it { should allow_value(nil).for (:wikipedia) }
    it { should allow_value(nil).for (:mag) }
  end
  describe 'relationships' do
    it { should belong_to :author }
  end
end
