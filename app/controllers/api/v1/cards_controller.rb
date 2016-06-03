module Api::V1
  class CardsController < ApiController
    def index
      cards = if params[:randomizers_only]
                Card.include_card_attributes.randomizers
              elsif params[:non_randomizers_only]
                Card.include_card_attributes.non_randomizers
              else
                Card.include_card_attributes.all
              end

      cards_json = ActiveModel::Serializer::CollectionSerializer
        .new(cards, each_serializer: CardSerializer)
      render json: cards_json
    end
  end
end
