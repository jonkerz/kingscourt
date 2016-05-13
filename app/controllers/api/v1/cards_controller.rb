module Api::V1
  class CardsController < ApiController
    def index
      cards = if params[:randomizers_only]
                Card.randomizers
              elsif params[:non_randomizers_only]
                Card.non_randomizers
              else
                Card.all
              end

      cards_json = ActiveModel::Serializer::CollectionSerializer
        .new(cards, each_serializer: CardSerializer)
      render json: cards_json
    end
  end
end
