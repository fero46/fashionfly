# frozen_string_literal: true

module Endpoint
  module V1
    class BaseController < ApplicationController
      respond_to :json

      before_action :check_format

      # http://blog.rudylee.com/2013/10/29/rails-4-cors/
      skip_before_action :verify_authenticity_token
      skip_before_action :prepare_for_mobile
      def check_format
        set_headers
        params[:format] == 'json'
        render nothing: true, status: 406 unless params[:format] == 'json' || request.headers['Accept'] =~ /json/
      end

      private

      # For all responses in this controller, return the CORS access control headers.
      def set_headers
        headers['Access-Control-Allow-Origin'] = '*'
        headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
        headers['Access-Control-Request-Method'] = '*'
        headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
      end

      def visit_me(visitable)
        ua = AgentOrange::UserAgent.new(request.user_agent)
        device = ua.device
        return if device.is_bot?

        Visit.run(visitable, current_user, visitor_cookie)
        cookies[:visit_cookie] = nil if current_user.present?
      rescue StandardError
      end
    end
  end
end
