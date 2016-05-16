module Api::V1
  class ExpansionsController < ApiController
    def index
      json = if params[:card_attributes]
               Expansion.all_card_attributes
             end
      render json: json
    end
  end
end
