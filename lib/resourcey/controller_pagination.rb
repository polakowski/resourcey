module Resourcey
  module ControllerPagination
    extend ActiveSupport::Concern

    included do
      class_attribute :pagination_enabled
      class_attribute :controller_paginator_name
      class_attribute :controller_paginator_options
    end

    private

    def paginated_resources
      return resources unless self.pagination_enabled
      
      paginator = current_paginator_class.new(params)
      paginator.paginate(resources)
    end

    def current_paginator_class
      Resourcey::Paginator.class_for(current_paginator_name)
    end

    def current_paginator_name
      self.controller_paginator_name || Config.default_paginator
    end

    module ClassMethods
      def paginate_with(name, opts = {})
        enable_pagination!
        self.controller_paginator_name = name
        self.controller_paginator_options = opts
      end

      def paginate(opts = {})
        paginate_with(Resourcey.config.default_paginator, opts)
      end

      private

      def enable_pagination!
        self.pagination_enabled = true
      end
    end
  end
end
