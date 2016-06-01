module Requests
  module JsonHelpers
    def json
      JSON.parse response.body
    end

    def group_description
      self.class.description
    end
  end
end
