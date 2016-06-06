module Api::V1
  class CardsController < ApiController
    def index
      cards = if params[:randomizable] == "true"
                Card.include_card_attributes.randomizable
              elsif params[:randomizable] == "false"
                Card.include_card_attributes.non_randomizable
              else
                Card.include_card_attributes.all
              end

      cards_json = ActiveModel::Serializer::CollectionSerializer
        .new(cards, each_serializer: CardSerializer)
      render json: cards_json
    end
  end
end
