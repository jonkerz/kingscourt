class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  protect_from_forgery with: :exception, if: Proc.new { |c| c.request.format != 'application/json' }
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  serialization_scope :view_context

  def index
  end

  def get_cards # TODO
    randomizers = Card.where(randomizable: true)
    cards = ActiveModel::Serializer::CollectionSerializer.new(randomizers, each_serializer: CardSerializer)
    render json: cards
  end

  def get_non_randomizers # TODO
    non_randomizers = Card.where(randomizable: false)
    cards = ActiveModel::Serializer::CollectionSerializer.new(non_randomizers, each_serializer: CardSerializer)
    render json: cards
  end

  private
    def default_serializer_options
      { root: false }
    end
end
