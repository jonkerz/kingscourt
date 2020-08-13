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
        if params[:randomizable] == "true"
          Card.include_card_attributes.randomizable
        elsif params[:randomizable] == "false"
          Card.include_card_attributes.non_randomizable
        else
          Card.include_card_attributes.all
        end
      end
  end
end
