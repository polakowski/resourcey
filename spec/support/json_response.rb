module Support
  module JsonResponse
    def json_response
      @json_response ||= JSON.parse(response.body)
    end
  end
end
