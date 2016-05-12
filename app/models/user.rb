class User < ActiveRecord::Base
  has_paper_trail

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :kingdoms
  has_many :favorite_kingdoms
  has_many :favorites, through: :favorite_kingdoms, source: :kingdom

  validates :username, presence: true,
    uniqueness: true, length: 3..25,
    format: { with: /\A[a-zA-Z0-9_\-.]+\Z/ }
  validates_confirmation_of :password
  validates_presence_of :password_confirmation, on: :create
end
