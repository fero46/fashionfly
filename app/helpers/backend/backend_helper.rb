# frozen_string_literal: true

module Backend
  module BackendHelper
    def activate(items)
      items.each do |item|
        return 'active' if controller.controller_path == "backend/#{item}"
      end
      ''
    end
  end
end
