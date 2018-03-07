module Support
  module JsonResponse
    def json_response
      @json_response ||= JSON.parse(response.body)
    end

    def json_errors
      @json_errors ||= json_response['errors']
    end
  end
end
