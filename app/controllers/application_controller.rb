class ApplicationController < ActionController::Base
  before_filter :set_paper_trail_whodunnit

  protect_from_forgery with: :exception, if: Proc.new { |c| c.request.format != 'application/json' }
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  serialization_scope :view_context

  def index
  end

  def get_cards
    randomizers = Card.where(randomizable: true)
    cards = ActiveModel::Serializer::CollectionSerializer.new(randomizers, each_serializer: CardSerializer)
    render json: cards
  end

  def get_non_randomizers
    non_randomizers = Card.where(randomizable: false)
    cards = ActiveModel::Serializer::CollectionSerializer.new(non_randomizers, each_serializer: CardSerializer)
    render json: cards
  end

  def get_all_expansion_attributes
    json = Expansion.all_card_attributes
    render json: json
  end

  private
    def default_serializer_options
      { root: false }
    end
end
