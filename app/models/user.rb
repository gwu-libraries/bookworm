class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :token_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :investigations

  def gql_id
    GraphQL::Schema::UniqueWithinType.encode(self.class.name, id)
  end

  def self.find_by_gql_id(gql_id)
    _type_name, object_id = GraphQL::Schema::UniqueWithinType.decode(gql_id)

    find(object_id)
  end

  def self.find_by_gql_ids(gql_ids)
    ids = gql_ids.map do |gql_id|
      GraphQL::Schema::UniqueWithinType.decode(gql_id).last
    end

    where(id: ids)
  end

end
