module Requests
  module JsonHelpers
    def last_json
      @json ||= JSON.parse(last_response.body)
    end
  end
end
