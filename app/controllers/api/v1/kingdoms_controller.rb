# TODO
module Api::V1
  class KingdomsController < ApiController
    def index
      kingdom = KingdomSerializer.new Kingdom.first, root: false
      json = {
        count: 6,
        next: "http://localhost:3000/api/v1/kingdoms/?expansions=2_5_6_7_8_9&page=2",
        previous: nil,
        count_all: 10,
        results: [kingdom, kingdom]
      }
      render json: json
    end

    def show
      render json: Kingdom.first
    end
  end
end
