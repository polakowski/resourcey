module Support
  module ActionParams
    def build_params(params = {})
      ActionController::Parameters.new(params)
    end
  end
end
