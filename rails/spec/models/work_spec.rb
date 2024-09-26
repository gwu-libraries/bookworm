# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Work, type: :model do
  describe 'validations' do
    # it { should validate_presence_of(:doi) }
    # it { should validate_presence_of(:title) }
  end

  describe 'relationships' do
    it { should have_one :works_biblio }
    it { should have_one :works_ids }
    it { should have_one :works_open_access }
    it { should have_many :works_related_works }
    it { should have_many(:related_works).through(:works_related_works) }
    it { should have_many :works_referenced_works }
    it { should have_many(:referenced_works).through(:works_referenced_works) }
  end
end
