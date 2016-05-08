class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  # TODO rename name to username
end
