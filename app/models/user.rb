class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  validates :username, presence: true,
    uniqueness: true, length: 3..25,
    format: { with: /\A[a-zA-Z0-9_\-.]+\Z/ }
end
