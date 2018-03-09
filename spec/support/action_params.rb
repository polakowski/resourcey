module Support
  module ActionParams
    def build_params(parent, params = {})
      ActionController::Parameters.new(build_params_hash(parent, params))
    end

    private

    def build_params_hash(parent, params)
      return params if parent.nil?

      Hash.new.tap do |result|
        result[parent] = params
      end
    end
  end
end
