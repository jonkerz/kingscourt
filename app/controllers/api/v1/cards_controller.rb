module Api::V1
  class CardsController < ApiController
    def index
      render json: serialized_cards
    end

    private

      def serialized_cards
        ActiveModel::Serializer::CollectionSerializer.new(cards, each_serializer: CardSerializer)
      end

      def cards
        query = Card.include_card_attributes

        case params[:randomizable]
        when "true"
          query.randomizable
        when "false"
          query.non_randomizable
        else
          query.all
        end
      end
  end
end
