require 'open-uri'

class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  protect_from_forgery with: :exception

  def index
  end

  # Temporarily cheating...
  def get_cards # TODO
    response = open('http://127.0.0.1:5000/api/get_cards/').read
    render json: response
  end

  private
    def default_serializer_options
      { root: false }
    end
end
