class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_keys
  has_many :keys, through: :user_keys

  has_many :user_investigations
  has_many :investigations, through: :user_investigations
  
end
