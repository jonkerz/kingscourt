class ApplicationController < ActionController::Base
  before_action :set_paper_trail_whodunnit
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception, if: Proc.new { |c| c.request.xhr? }
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.xhr? }

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

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit :sign_up, keys: [:username]
    end

  private
    def default_serializer_options
      { root: false }
    end
end
