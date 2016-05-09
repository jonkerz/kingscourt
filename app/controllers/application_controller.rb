class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken

  protect_from_forgery with: :exception, if: Proc.new { |c| c.request.format != 'application/json' }
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  def index
  end

  def get_cards # TODO
    cards = ActiveModel::ArraySerializer.new(Card.all, each_serializer: CardSerializer)
    render json: cards
  end

  private
    def default_serializer_options
      { root: false }
    end
end
