module Api
  module V1
    class ExpansionsController < ApiController
      def index
        json = (Expansion.all_card_attributes if params[:card_attributes])
        render json: json
      end
    end
  end
end
