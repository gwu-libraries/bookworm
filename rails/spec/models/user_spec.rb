require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
  end

  describe 'relationships' do
    it { should have_many(:investigations) }
  end

  describe 'methods' do
    it 'has a graphql id' do
      user = FactoryBot.create(:user)

      expect(user.gql_id).to be_a String
    end

    it 'can be found be graphql id' do
      user = FactoryBot.create(:user)

      gql_id = user.gql_id

      expect(User.find_by_gql_id(gql_id)).to eq(user)
    end

    it 'can find multiple users with multiple graphql ids' do
      user_1 = FactoryBot.create(:user)
      user_2 = FactoryBot.create(:user)

      expect(User.find_by_gql_ids([user_1.gql_id, user_2.gql_id])).to eq(
        [user_1, user_2]
      )
    end
  end
end
